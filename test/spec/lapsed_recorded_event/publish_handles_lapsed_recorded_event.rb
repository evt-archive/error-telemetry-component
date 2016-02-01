require_relative '../spec_init'

context "Publish" do
  context "Recorded event has lapsed" do
    test do
      # handler clock is set to time + lapse interval
      # send recorded event
      # writes NotPublished
      # Note: projection: entity picks up the Lapsed time
      # from the Lapsed event
    end
  end
end
