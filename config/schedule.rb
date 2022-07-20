every :day, :at => "11am" do
  runner "QuoteJob.perform_now"
end

every 1.day, at: '12:00 am' do
  runner "QuoteJob.perform_now"
end