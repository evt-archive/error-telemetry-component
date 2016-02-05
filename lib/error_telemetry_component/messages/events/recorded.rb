module ErrorTelemetryComponent
  module Messages
    module Events
      class Recorded
        include EventStore::Messaging::Message
        include Lapse

        attribute :error_id
        attribute :error
        attribute :hostname
        attribute :time

        def self.___build(data)
          new.tap do |instance|
            SetAttributes.(instance, data, exclude: :error)

            ## TODO Remove this. It should not be a complex object. [Scott, Sun Jan 31 2016]
            error_data = ErrorData.build data['error']

            instance.error = error_data
          end
        end

        def lapsed?(now)
          elapsed_milliseconds(now) > self.class.effective_milliseconds
        end
      end
    end
  end
end
