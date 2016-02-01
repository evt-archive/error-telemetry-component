module ErrorTelemetryComponent
  class ConvertErrorData
    def self.call(recorded_event)
      logger.trace "Converting recorded event to Raygun data"
      logger.data "Recorded event: #{recorded_event.inspect}"

      data = RaygunClient::Data.new

      data.occurred_time = recorded_event.time
      data.machine_name = recorded_event.hostname
      data.client = RaygunClient::Data::ClientInfo.build

      raw_error_data = Casing::Underscore.(recorded_event.error)
      error_data = ErrorData.build(raw_error_data)

      data.error = error_data

      data.custom_data = { :error_id => recorded_event.error_id }

      logger.debug "Converted recorded event to Raygun data"
      logger.data "Raygun data: #{data.inspect}"

      data
    end

    def self.logger
      @logger ||= Telemetry::Logger.build self
    end
  end
end
