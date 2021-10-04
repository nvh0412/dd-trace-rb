require 'forwardable'

require 'datadog/core/environment/identity'
require 'ddtrace/ext/runtime'
require 'ddtrace/span'
require 'ddtrace/forced_tracing'

module Datadog
  # Represents the act of taking a span measurement.
  # It gives a Span a context which can be used to
  # manage and decorate the Span.
  # When completed, it yields the Span.
  class SpanOperation
    extend Forwardable

    FORWARDED_METHODS = [
      :allocations,
      :clear_metric,
      :clear_tag,
      :duration,
      :duration=,
      :end_time,
      :end_time=,
      :get_metric,
      :get_tag,
      :name,
      :name=,
      :parent_id,
      :parent_id=,
      :pretty_print,
      :resource,
      :resource=,
      :sampled,
      :sampled=,
      :service,
      :service=,
      :set_error,
      :set_metric,
      :set_parent,
      :set_tag,
      :set_tags,
      :span_id,
      :span_id=,
      :span_type,
      :span_type=,
      :start,
      :start_time,
      :start_time=,
      :started?,
      :status,
      :status=,
      :stop,
      :stopped?,
      :to_hash,
      :to_json,
      :to_msgpack,
      :to_s,
      :trace_id,
      :trace_id=
    ].to_set.freeze

    def initialize(span_name, options = {})
      # Resolve service name
      parent = options[:child_of]
      options[:service] ||= parent.service unless parent.nil?

      # Build span options
      span_options = {}
      span_options[:parent_id] = options[:parent_id] if options.key?(:parent_id)
      span_options[:resource] = options[:resource] if options.key?(:resource)
      span_options[:service] = options[:service] if options.key?(:service)
      span_options[:span_type] = options[:span_type] if options.key?(:span_type)
      span_options[:tags] = options[:tags] if options.key?(:tags)
      span_options[:trace_id] = options[:trace_id] if options.key?(:trace_id)

      @span = Span.new(span_name, **span_options)
      @tracer = options[:tracer]
      @context = options[:context]

      # Add span to the context, if provided.
      @context.add_span(self) if @context

      if parent.nil?
        # Root span: set default tags.
        set_tag(Datadog::Ext::Runtime::TAG_PID, Process.pid)
        set_tag(Datadog::Ext::Runtime::TAG_ID, Datadog::Core::Environment::Identity.id)
      else
        # Only set parent if explicitly provided.
        # We don't want it to override context-derived
        # IDs if it's a distributed trace w/o a parent span.
        self.parent = parent
      end
    end

    attr_reader :parent
    attr_accessor :span, :tracer, :context

    # Set span parent
    def parent=(parent)
      @parent = parent
      span.parent = parent && parent.span
    end

    def detach_from_context!
      @context = nil
    end

    def finish(end_time = nil)
      return span if finished?

      # Stop the span
      span.stop(end_time)

      begin
        context.close_span(self) if context
        tracer.record_span(self) if tracer
      rescue StandardError => e
        Datadog.logger.debug("error recording finished trace: #{e} Backtrace: #{e.backtrace.first(3)}")
        Datadog.health_metrics.error_span_finish(1, tags: ["error:#{e.class.name}"])
      end

      span
    end

    def finished?
      span.stopped?
    end

    # Forward instance methods except ones that would cause identity issues
    def_delegators :span, *FORWARDED_METHODS

    # Additional extensions
    prepend ForcedTracing::SpanOperation
  end
end