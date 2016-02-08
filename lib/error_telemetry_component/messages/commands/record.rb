module ErrorTelemetryComponent
  module Messages
    module Commands
      class Record
        include EventStore::Messaging::Message

        attribute :error_id
        attribute :error
        attribute :hostname
        attribute :source
        attribute :time

        def self.build(data=nil)
          data ||= {}
          Serialize::Read.instance(data, self)
        end

        def to_h
          Serialize::Write.raw_data(self)
        end

        module Serializer
          def self.raw_data(instance)
            data = instance.attributes

            error_raw_data = Serialize::Write.raw_data(instance.error)
            data[:error] = error_raw_data

            data
          end

          def self.instance(raw_data)
            Telemetry::Logger.get(self).fubar "Remove special handling of string keys after event-store-messaging starts emitting underscore cased symbol keys [Nathan Ladd, Scott Bellware, Fri Feb 5 2016]"
            raw_data = JSON.parse(JSON.generate(raw_data), :symbolize_names => true)

            instance = Record.new

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
