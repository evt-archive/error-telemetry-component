module TelemetryService
  module Error
    module Messages
      module Events
        class Recorded
          include EventStore::Messaging::Message

          attribute :error_id
          attribute :error
          attribute :hostname
          attribute :time

          def self.build(data)
            new.tap do |instance|
              SetAttributes.(instance, data, exclude: :error)
            end
          end
        end
      end
    end
  end
end
