module DIHelpers
  module ClassMethods
    def di_test
      if PlatformHelpers.jruby?
        before(:all) do
          skip "Dynamic instrumentation is not supported on JRuby"
        end
      end
      if RUBY_VERSION < "2.6"
        before(:all) do
          skip "Dynamic instrumentation requires Ruby 2.6 or higher"
        end
      end
    end

    def mock_settings_for_di(&block)
      let(:settings) do
        double('settings').tap do |settings|
          allow(settings).to receive(:dynamic_instrumentation).and_return(di_settings)
          if block
            instance_exec(settings, &block)
          end
        end
      end

      let(:di_settings) do
        double('di settings').tap do |settings|
          allow(settings).to receive(:internal).and_return(di_internal_settings)
        end
      end

      let(:di_internal_settings) do
        double('di internal settings')
      end
    end

    def with_code_tracking
      around do |example|
        Datadog::DI.activate_tracking!
        example.run
        Datadog::DI.deactivate_tracking!
      end
    end

    def without_code_tracking
      before do
        Datadog::DI.deactivate_tracking!
      end
    end
  end

  module InstanceMethods
  end
end

RSpec.configure do |config|
  config.extend DIHelpers::ClassMethods
  config.include DIHelpers::InstanceMethods
end
