module ErrorTelemetryComponent
  module Handlers
    class Record
      include EventStore::Messaging::Handler
      include EventStore::Messaging::StreamName

      dependency :clock, Clock::UTC
      dependency :logger, Telemetry::Logger
      dependency :store, Store
      dependency :writer, EventStore::Messaging::Writer

      category :error

      def configure_dependencies
        Clock::UTC.configure self
        Telemetry::Logger.configure self
        Store.configure self
        EventStore::Messaging::Writer.configure self
      end

      handle Messages::Commands::Record do |command|
        version = store.get_version command.error_id

        if version != :no_stream
          return
        end

        logger.todo "Remove special handling of error after event-store-messaging uses the serialize library [Nathan Ladd, Scott Bellware, Fri Feb 5 2016]"
        event = Messages::Events::Recorded.proceed command, :exclude => [:error, :time]
        event.time = clock.iso8601
        event.error = command.error

        stream_name = stream_name(event.error_id)

        writer.write_initial event, stream_name
      end
    end
  end
end

