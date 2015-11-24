require 'socket'

require 'eventide'
require 'raygun_client'

require 'initializer'; Initializer.activate

require 'telemetry/messages/commands/record_error'
require 'telemetry/messages/events/error_recorded'
require 'telemetry/entity'
require 'telemetry/store'
require 'telemetry/projection'
require 'telemetry/handler'
require 'telemetry/dispatcher'
require 'telemetry/host_info'
require 'telemetry/record_error'
