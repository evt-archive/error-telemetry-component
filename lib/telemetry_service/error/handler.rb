module TelemetryService
  module Error
    class Handler
      include EventStore::Messaging::Handler
      include EventStore::Messaging::StreamName
      include Messages::Events
      include Messages::Commands

      dependency :clock, Clock::UTC
      dependency :writer, EventStore::Messaging::Writer

      category 'error'

      def configure_dependencies
        Clock::UTC.configure self
        EventStore::Messaging::Writer.configure self
      end

      handle Recorded do |event|
        command = Publish.proceed(event, copy: [
          :error_id,
          :error,
          :hostname,
          :time
        ])

        stream_name = command_stream_name(command.error_id)
        writer.write command, stream_name
      end

      # handle Publish do |command|
      # end

      # handle Published do |event|
      # end
    end
  end
end
