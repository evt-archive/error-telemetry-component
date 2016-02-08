class Service
  dependency :logger, Telemetry::Logger

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
    service_name
  end

  def self.service_name
    'error-telemetry'
  end

  def announce_start
    logger.info "Starting service: #{service_name}"
  end
end
