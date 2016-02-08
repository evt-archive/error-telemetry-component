class Service
  dependency :logger, Telemetry::Logger

  # TODO Macro in service abstraction that records the service name
  # service_name 'error-telemetry'

  # TODO Macro in service abstraction that records the service identifier
  # Note: Is this needed given the service name? Without it, service names
  # are permanent and immutable
  # service_identifier '{some uuid}'

  def self.service_name
    'error-telemetry'
  end

  initializer :service_name

  def self.build(service_name)
    new(service_name).tap do |instance|
      Telemetry::Logger.configure instance
    end
  end

  def self.start
    service_name = self.service_name
    instance = build(service_name)
    instance.start
  end

  def start
    announce_start
    start_components
    service_name
  end

  def start_components
    dispatcher = ErrorTelemetryComponent::Dispatcher.build
    command_subscription = EventStore::Messaging::Subscription.build '$ce-error:command', dispatcher
    event_subscription = EventStore::Messaging::Subscription.build '$ce-error', dispatcher

    cooperation = ProcessHost::Cooperation.build
    cooperation.exception_notifier = -> process, error do
      logger.fatal "Uncaught exception (Process: #{process.inspect}, Error: #{error.message.inspect})"
      ErrorTelemetryComponent::Client::Record.(error, service_name)
    end

    cooperation.register command_subscription, 'command-handlers'
    cooperation.register event_subscription, 'event-handlers'

    # TODO Still need name for this version of start [Scott, Sun Feb 7 2016]
    # TODO Would be good to have a shutdown message, but need atomic unit of work [Scott, Sun Feb 7 2016]
    cooperation.start!
  end

  def announce_start
    logger.info "Starting service: #{service_name}"
  end
end
