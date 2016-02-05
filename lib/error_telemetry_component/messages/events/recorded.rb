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

        def self.build(data=nil)
          data ||= {}
          Serialize::Read.instance(data, self)
        end

        def to_h
          Serialize::Write.raw_data(self)
        end

        def lapsed?(now)
          elapsed_milliseconds(now) > self.class.effective_milliseconds
        end

        module Serializer
          def self.raw_data(instance)
            data = instance.attributes

            error_raw_data = Serialize::Write.raw_data(instance.error)
            data[:error] = error_raw_data

            data
          end

          def self.instance(raw_data)
            raw_data = Casing::Underscore.(raw_data)

            instance = Recorded.new

            SetAttributes.(instance, raw_data, exclude: :error)

            error_raw_data = raw_data[:error]

            if error_raw_data
              instance.error = ErrorData.build(error_raw_data)
            end

            instance
          end
        end
      end
    end
  end
end
