# frozen_string_literal: true

require_relative '../patcher'
require_relative 'ext'
require_relative 'events'
require_relative 'producer_tracer'

module Datadog
  module Tracing
    module Contrib
      module Kafka
        # Patcher enables patching of 'kafka' module.
        module Patcher
          include Contrib::Patcher

          module_function

          def target_version
            Integration.version
          end

          def patch
            ::Kafka::Producer.prepend(ProducerTracer)

            # Subscribe to Kafka events
            Events.subscribe!
          end
        end
      end
    end
  end
end
