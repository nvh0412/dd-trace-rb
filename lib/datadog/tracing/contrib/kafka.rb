# frozen_string_literal: true

require_relative 'component'
require_relative 'kafka/integration'
require_relative 'kafka/distributed/propagation'

module Datadog
  module Tracing
    module Contrib
      # `Sidekiq` integration public API
      module Kafka
        def self.inject(digest, data)
          raise 'Please invoke Datadog.configure at least once before calling this method' unless @propagation

          @propagation.inject!(digest, data)
        end

        def self.extract(data)
          raise 'Please invoke Datadog.configure at least once before calling this method' unless @propagation

          @propagation.extract(data)
        end

        Contrib::Component.register('kafka') do |config|
          tracing = config.tracing
          tracing.propagation_style

          @propagation = Kafka::Distributed::Propagation.new(
            propagation_style_inject: tracing.propagation_style_inject,
            propagation_style_extract: tracing.propagation_style_extract,
            propagation_extract_first: tracing.propagation_extract_first
          )
        end
      end
    end
  end
end
