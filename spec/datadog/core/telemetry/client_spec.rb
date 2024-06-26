require 'spec_helper'

require 'datadog/core/telemetry/client'

RSpec.describe Datadog::Core::Telemetry::Client do
  subject(:client) do
    described_class.new(
      enabled: enabled,
      heartbeat_interval_seconds: heartbeat_interval_seconds,
      dependency_collection: dependency_collection
    )
  end

  let(:enabled) { true }
  let(:heartbeat_interval_seconds) { 1.3 }
  let(:dependency_collection) { true }
  let(:emitter) { double(Datadog::Core::Telemetry::Emitter) }
  let(:response) { double(Datadog::Core::Telemetry::Http::Adapters::Net::Response) }
  let(:not_found) { false }

  before do
    allow(Datadog::Core::Telemetry::Emitter).to receive(:new).and_return(emitter)
    allow(emitter).to receive(:request).and_return(response)
    allow(response).to receive(:not_found?).and_return(not_found)
  end

  describe '#initialize' do
    after do
      client.stop!
    end

    context 'with default parameters' do
      subject(:client) do
        described_class.new(
          heartbeat_interval_seconds: heartbeat_interval_seconds,
          dependency_collection: dependency_collection
        )
      end

      it { is_expected.to be_a_kind_of(described_class) }
      it { expect(client.enabled).to be(true) }
    end

    context 'when :enabled is false' do
      let(:enabled) { false }
      it { is_expected.to be_a_kind_of(described_class) }
      it { expect(client.enabled).to be(false) }
    end

    context 'when enabled' do
      let(:enabled) { true }

      it { is_expected.to be_a_kind_of(described_class) }
      it { expect(client.enabled).to be(true) }
    end
  end

  describe '#disable!' do
    after do
      client.stop!
    end

    it { expect { client.disable! }.to change { client.enabled }.from(true).to(false) }
  end

  describe '#started!' do
    subject(:started!) { client.started! }

    after do
      client.stop!
    end

    context 'when disabled' do
      let(:enabled) { false }
      it do
        started!
        expect(emitter).to_not have_received(:request)
      end
    end

    context 'when enabled' do
      let(:enabled) { true }

      context 'when dependency_collection is true' do
        it do
          app_started = double
          allow(Datadog::Core::Telemetry::Event::AppStarted).to receive(:new).with(no_args).and_return(app_started)

          dependencies = double
          allow(Datadog::Core::Telemetry::Event::AppDependenciesLoaded)
            .to receive(:new).with(no_args).and_return(dependencies)

          started!
          expect(emitter).to have_received(:request).with(app_started)
          expect(emitter).to have_received(:request).with(dependencies)
        end
      end

      context 'when dependency_collection is false' do
        let(:dependency_collection) { false }

        it do
          app_started = double
          allow(Datadog::Core::Telemetry::Event::AppStarted).to receive(:new).with(no_args).and_return(app_started)

          dependencies = double
          allow(Datadog::Core::Telemetry::Event::AppDependenciesLoaded)
            .to receive(:new).with(no_args).and_return(dependencies)

          started!
          expect(emitter).to have_received(:request).with(app_started)
          expect(emitter).to_not have_received(:request).with(dependencies)
        end

        context 'with heartbeat' do
          let(:heartbeat_interval_seconds) { 0 }

          it 'sends a heartbeat strictly after app-started' do
            @sent_hearbeat = false
            allow(emitter).to receive(:request).with(kind_of(Datadog::Core::Telemetry::Event::AppHeartbeat)) do
              # Ensure app-started was already sent by now
              expect(emitter).to have_received(:request).with(kind_of(Datadog::Core::Telemetry::Event::AppStarted))
              @sent_hearbeat = true
              response
            end

            client.started!

            try_wait_until { @sent_hearbeat }
          end
        end
      end
    end

    context 'when internal error returned by emitter' do
      let(:response) { Datadog::Core::Telemetry::Http::InternalErrorResponse.new('error') }

      it { expect { started! }.to_not raise_error }
    end

    context 'when response returns 404' do
      let(:not_found) { true }

      before do
        logger = double(Datadog::Core::Logger)
        allow(logger).to receive(:debug).with(any_args)
        allow(Datadog).to receive(:logger).and_return(logger)
      end

      it do
        started!
        expect(client.enabled).to be(false)
        expect(client.unsupported).to be(true)
        expect(Datadog.logger).to have_received(:debug).with(
          'Agent does not support telemetry; disabling future telemetry events.'
        )
      end
    end

    context 'when in fork' do
      before { skip 'Fork not supported on current platform' unless Process.respond_to?(:fork) }

      it do
        client
        expect_in_fork do
          expect(emitter).to_not receive(:request)
          client.started!
        end
      end
    end
  end

  describe '#emit_closing!' do
    subject(:emit_closing!) { client.emit_closing! }

    after do
      client.stop!
    end

    context 'when disabled' do
      let(:enabled) { false }
      it do
        emit_closing!
        expect(emitter).to_not have_received(:request)
      end
    end

    context 'when enabled' do
      let(:enabled) { true }
      it do
        double = double()
        allow(Datadog::Core::Telemetry::Event::AppClosing).to receive(:new).with(no_args).and_return(double)

        emit_closing!
        expect(emitter).to have_received(:request).with(double)
      end

      it { is_expected.to be(response) }
    end

    context 'when in fork' do
      before { skip 'Fork not supported on current platform' unless Process.respond_to?(:fork) }

      it do
        client
        expect_in_fork do
          expect(emitter).to_not receive(:request)
          client.started!
        end
      end
    end
  end

  describe '#stop!' do
    subject(:stop!) { client.stop! }
    let(:worker) { instance_double(Datadog::Core::Telemetry::Heartbeat) }

    before do
      allow(Datadog::Core::Telemetry::Heartbeat).to receive(:new)
        .with(enabled: enabled, heartbeat_interval_seconds: heartbeat_interval_seconds).and_return(worker)
      allow(worker).to receive(:start)
      allow(worker).to receive(:stop)
    end

    context 'when disabled' do
      let(:enabled) { false }
      it 'does not raise error' do
        stop!
      end
    end

    context 'when enabled' do
      let(:enabled) { true }

      context 'when stop! has been called already' do
        it 'does not raise error' do
          stop!
          stop!
        end
      end
    end
  end

  describe '#integrations_change!' do
    subject(:integrations_change!) { client.integrations_change! }

    after do
      client.stop!
    end

    context 'when disabled' do
      let(:enabled) { false }
      it do
        integrations_change!
        expect(emitter).to_not have_received(:request)
      end
    end

    context 'when enabled' do
      let(:enabled) { true }
      it do
        double = double()
        allow(Datadog::Core::Telemetry::Event::AppIntegrationsChange).to receive(:new).with(no_args).and_return(double)

        integrations_change!
        expect(emitter).to have_received(:request).with(double)
      end

      it { is_expected.to be(response) }
    end

    context 'when in fork' do
      before { skip 'Fork not supported on current platform' unless Process.respond_to?(:fork) }

      it do
        client
        expect_in_fork do
          expect(emitter).to_not receive(:request)
          client.started!
        end
      end
    end
  end

  describe '#client_configuration_change!' do
    subject(:client_configuration_change!) { client.client_configuration_change!(changes) }
    let(:changes) { double('changes') }

    after do
      client.stop!
    end

    context 'when disabled' do
      let(:enabled) { false }
      it do
        client_configuration_change!
        expect(emitter).to_not have_received(:request)
      end
    end

    context 'when enabled' do
      let(:enabled) { true }
      it do
        double = double()
        allow(Datadog::Core::Telemetry::Event::AppClientConfigurationChange).to receive(:new).with(
          changes,
          'remote_config'
        ).and_return(double)

        client_configuration_change!
        expect(emitter).to have_received(:request).with(double)
      end

      it { is_expected.to be(response) }
    end

    context 'when in fork' do
      before { skip 'Fork not supported on current platform' unless Process.respond_to?(:fork) }

      it do
        client
        expect_in_fork do
          expect(emitter).to_not receive(:request)
          client.started!
        end
      end
    end
  end
end
