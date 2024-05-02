# frozen_string_literal: true

require_relative 'producer_interceptor'

module Datadog
  module Tracing
    module Contrib
      module Kafka
        module ProducerTracer
          def initialize(*args)
            super

            logger = args[0][:logger]
            interceptors = args[0][:interceptors]
            interceptors << ProducerInterceptor.new
            @interceptors = ::Kafka::Interceptors.new(interceptors: interceptors, logger: logger)
          end
        end
      end
    end
  end
end
