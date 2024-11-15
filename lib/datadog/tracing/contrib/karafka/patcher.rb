# frozen_string_literal: true

require_relative '../patcher'
require_relative 'events'

module Datadog
  module Tracing
    module Contrib
      module Karafka
        # Patcher enables patching of 'kafka' module.
        module Patcher
          include Contrib::Patcher

          module_function

          def target_version
            Integration.version
          end

          def patch
            Events.subscribe!
          end
        end
      end
    end
  end
end
