# module TelemetryService
#   module Error
#     class ConvertErrorData
#       def self.call(recorded_event)
#         data = RaygunClient::Data.new

#         data.occurred_time = recorded_event.time
#         data.machine_name = recorded_event.hostname
#         data.client = RaygunClient::Data::ClientInfo.build

#         raw_error_data = Casing::Underscore.(recorded_event.error)

#         error_data = ErrorData.build(raw_error_data)

#         data.error = error_data

#         data.custom_data = { :error_id => recorded_event.error_id }

#         data
#       end
#     end
#   end
# end
