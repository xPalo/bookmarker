set :environment, "development"

every 1.day, at: "3:33 pm" do
  runner "QuoteJob.perform_now"
end