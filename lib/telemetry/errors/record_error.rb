module Telemetry
  module Errors
    class RecordError
      attr_reader :error

      dependency :writer, EventStore::Messaging::Writer

      def initialize(error)
        @error = error
      end

      def self.build(error, writer: nil)
        instance = new error
        instance.writer = writer or
          EventStore::Messaging::Writer.configure instance
        instance
      end

      def self.call(*arguments)
        instance = build *arguments
        instance.()
      end

      def call
        writer.write command
      end

      def command
        raise NotImplementedError
      end
    end
  end
end
