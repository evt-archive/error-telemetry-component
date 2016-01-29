require_relative './spec_init'

# handler clock is set to time + lapse interval
# send recorded event
# writes NotPublished
# Note: projection: entity picks up the Lapsed time
# from the Lapsed event

context "Recorded event handled has lapsed" do
  test
end
