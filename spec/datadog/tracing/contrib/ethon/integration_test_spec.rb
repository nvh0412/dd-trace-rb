require 'json'
require 'stringio'
require 'typhoeus'

require 'datadog/tracing/trace_digest'
require 'datadog/tracing/contrib/ethon/easy_patch'
require 'datadog/tracing/contrib/ethon/multi_patch'
require 'datadog/tracing/contrib/ethon/shared_examples'
require 'datadog/tracing/contrib/support/spec_helper'
require 'datadog/tracing/contrib/support/http'

require 'spec/datadog/tracing/contrib/ethon/support/thread_helpers'

RSpec.describe 'Ethon integration tests' do
  skip_unless_integration_testing_enabled

  context 'with Easy HTTP request' do
    subject(:request) do
      easy = EthonSupport.ethon_easy_new
      easy.http_request(url, 'GET', params: query, timeout_ms: timeout * 1000)
      easy.perform
      # Use Typhoeus response wrapper to simplify tests
      Typhoeus::Response.new(easy.mirror.options)
    end

    it_behaves_like 'instrumented request' do
      context 'distributed tracing disabled' do
        let(:configuration_options) { super().merge(distributed_tracing: false) }

        shared_examples_for 'does not propagate distributed headers' do
          let(:return_headers) { true }

          it 'does not propagate the headers' do
            response = request
            headers = JSON.parse(response.body)['headers']

            expect(headers).not_to include('x-datadog-parent-id', 'x-datadog-trace-id')
          end
        end

        it_behaves_like 'does not propagate distributed headers'

        context 'with sampling priority' do
          let(:return_headers) { true }
          let(:sampling_priority) { 2 }

          before do
            tracer.continue_trace!(
              Datadog::Tracing::TraceDigest.new(
                trace_sampling_priority: sampling_priority
              )
            )
          end

          it_behaves_like 'does not propagate distributed headers'

          it 'does not propagate sampling priority headers' do
            response = request
            headers = JSON.parse(response.body)['headers']

            expect(headers).not_to include('x-datadog-sampling-priority')
          end
        end
      end
    end
  end

  context 'with simple Easy & headers override' do
    subject(:request) do
      easy = EthonSupport.ethon_easy_new(url: url)
      easy.customrequest = 'GET'
      easy.set_attributes(timeout_ms: timeout * 1000)
      easy.headers = request_headers
      easy.perform
      # Use Typhoeus response wrapper to simplify tests
      Typhoeus::Response.new(easy.mirror.options)
    end

    let(:request_headers) { { key: 'value' } }

    it_behaves_like 'instrumented request' do
      let(:method) { 'N/A' }
    end

    context 'when configured with global tag headers' do
      include_context 'integration context'

      before { request }

      let(:request_headers) { { 'Request-Id' => 'test-request' } }

      include_examples 'with request tracer header tags' do
        let(:request_header_tag) { 'request-id' }
        let(:request_header_tag_value) { 'test-request' }
      end

      include_examples 'with response tracer header tags' do
        let(:response_header_tag) { 'connection' }
        let(:response_header_tag_value) { 'Keep-Alive' }
      end
    end
  end

  context 'with single Multi request' do
    subject(:request) do
      multi = Ethon::Multi.new
      easy = EthonSupport.ethon_easy_new
      easy.http_request(url, 'GET', params: query, timeout_ms: timeout * 1000)
      multi.add(easy)
      multi.perform
      Typhoeus::Response.new(easy.mirror.options)
    end

    it_behaves_like 'instrumented request'
  end
end
