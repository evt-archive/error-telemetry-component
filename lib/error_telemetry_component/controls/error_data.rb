module ErrorTelemetryComponent
  module Controls
    module ErrorData
      def self.example
        ::ErrorData::Controls::ErrorData.example
      end

      def self.data
        ::Serialize::Write.raw_data(example, :json)
      end
    end
  end
end
