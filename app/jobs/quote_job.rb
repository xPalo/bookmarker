class QuoteJob < ApplicationJob
  queue_as :default

  def perform(*args)
    require "uri"
    require "net/http"
    require "openssl"

    url = URI("https://quotes15.p.rapidapi.com/quotes/random/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = "dd40906b89msh17a4d0e1e155669p1db7acjsn0468c37512d7"
    request["X-RapidAPI-Host"] = "quotes15.p.rapidapi.com"

    response = http.request(request)
    res = JSON.parse(response.read_body)

    puts res

    quote = Quote.new("language_code" => res["language_code"], "content" => res["content"], "url" => res["url"], "published_at" => Time.now.in_time_zone('Europe/Bratislava'), "author" => res["originator"]["name"])
    quote.save!
  end
end
