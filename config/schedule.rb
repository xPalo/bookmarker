set :environment, "development"

every 1.day, at: "9:00 am" do
  runner "QuoteJob.perform_later"
end