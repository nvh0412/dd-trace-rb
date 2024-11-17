# frozen_string_literal: true

require_relative '../../ext'
require_relative '../../event'

module Datadog
  module Tracing
    module Contrib
      module Karafka
        module Events
          module Worker
            module Process
              include Karafka::Event

              def self.subscribe!
                ::Karafka.monitor.subscribe 'worker.process' do |event|
                  # Start a trace
                  span = Tracing.trace('karafka.consumer', **span_options)

                  job = event[:job]
                  job_type = job.class.to_s.split('::').last
                  consumer = job.executor.topic.consumer
                  topic = job.executor.topic.name

                  action = case job_type
                     when 'Periodic'
                       'tick'
                     when 'PeriodicNonBlocking'
                       'tick'
                     when 'Shutdown'
                       'shutdown'
                     when 'Revoked'
                       'revoked'
                     when 'RevokedNonBlocking'
                       'revoked'
                     when 'Idle'
                       'idle'
                     else
                       'consume'
                     end

                  span.resource = "#{consumer}##{action}"
                  span.set_tag(Ext::TAG_TOPIC, topic) if topic

                  if action == 'consume'
                    span.set_tag(Ext::TAG_MESSAGE_COUNT, job.messages.count)
                    span.set_tag(Ext::TAG_PARTITION, job.executor.partition)
                    span.set_tag(Ext::TAG_OFFSET, job.messages.first.metadata.offset)
                  end

                  puts "Starting span for #{consumer}##{action} with topic #{topic} and #{job.messages.count} messages"

                  span
                end

                ::Karafka.monitor.subscribe 'worker.processed' do |event|
                  Tracing.active_span do |span|
                    # If no active span, return.
                    return nil if span.nil?

                    # Finish the span
                    span.finish(finish)
                  end
                end
              end

              def span_options
                super.merge({ tags: { Tracing::Metadata::Ext::TAG_OPERATION => Ext::TAG_OPERATION_PROCESS_MESSAGE } })
              end
            end
          end
        end
      end
    end
  end
end
