#set :environment, "development"

every 1.day, at: "12:00 pm" do
  runner "QuoteJob.perform_later"
end