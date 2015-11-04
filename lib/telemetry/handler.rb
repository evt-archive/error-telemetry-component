module Telemetry
  module Errors
    class Handler
      include EventStore::Messaging::Handler
      include Messages

    end
  end
end
