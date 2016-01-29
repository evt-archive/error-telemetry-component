module ErrorTelemetryComponent
  module Handlers
    class Record
      include EventStore::Messaging::Handler
      include EventStore::Messaging::StreamName

      dependency :store, Store
      dependency :writer, EventStore::Messaging::Writer

      category :error

      def configure_dependencies
        Store.configure self
        EventStore::Messaging::Writer.configure self
      end

      handle Messages::Commands::Record do |command|
        version = store.get_version command.error_id
        if version != :no_stream
          return
        end

        event = Messages::Events::Recorded.build command

        stream_name = stream_name(event.error_id)

        writer.write_initial event, stream_name
      end
    end
  end
end

