# frozen_string_literal: true

module Datadog
  module Tracing
    module Contrib
      module Kafka
        # This class is an interceptor for Kafka producer where we use to inject tracing
        # into the Kafka message header
        class ProducerInterceptor
          def initialize; end

          def call(pending_message)
            Datadog::Tracing.trace(Ext::SPAN_PRODUCE_MESSAGE, service: @sidekiq_service) do |_span, trace_op|
              Kafka.inject(trace_op, pending_message.headers) if configuration[:distributed_tracing]
            end

            pending_message
          end

          private

          def configuration
            Datadog.configuration.tracing[:kafka]
          end
        end
      end
    end
  end
end
