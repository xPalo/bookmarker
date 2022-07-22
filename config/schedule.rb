set :environment, "development"

every 1.day, at: "9:00 am" do
  runner "QuoteJob.perform_later"
end

every 1.month, at: "12:00 am" do
  runner "ScrapeBooksJob.perform_later"
end