# frozen_string_literal: true

module Datadog
  module Tracing
    module Contrib
      module Karafka
        module Ext
          ENV_ENABLED = 'DD_TRACE_KARAFKA_ENABLED'

          TAG_TOPIC = 'kafka.topic'
          TAG_PARTITION = 'kafka.partition'
          TAG_OFFSET = 'kafka.offset'
          TAG_OFFSET_LAG = 'kafka.offset_lag'
          TAG_MESSAGE_COUNT = 'kafka.message_count'
          TAG_MESSAGE_KEY = 'kafka.message_key'
        end
      end
    end
  end
end
