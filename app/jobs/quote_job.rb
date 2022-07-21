class QuoteJob < ApplicationJob
  queue_as :default
  require "uri"
  require "net/http"
  require "openssl"

  def perform(*args)
    url = URI("https://quotes15.p.rapidapi.com/quotes/random/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = "dd40906b89msh17a4d0e1e155669p1db7acjsn0468c37512d7"
    request["X-RapidAPI-Host"] = "quotes15.p.rapidapi.com"

    response = http.request(request)
    res = JSON.parse(response.read_body)
    content_sk = translate(res["content"])

    puts res
    puts "CONTENT SK: #{content_sk}"

    quote = Quote.new("language_code" => res["language_code"], "content_en" => res["content"], "content_sk" => content_sk, "url" => res["url"], "published_at" => Time.now.in_time_zone('Europe/Bratislava'), "author" => res["originator"]["name"])
    quote.save!
  end

  private

  def translate(quote)
    q = ERB::Util.url_encode(quote)

    url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request["content-type"] = "application/x-www-form-urlencoded"
    request["Accept-Encoding"] = "application/gzip"
    request["X-RapidAPI-Key"] = "dd40906b89msh17a4d0e1e155669p1db7acjsn0468c37512d7"
    request["X-RapidAPI-Host"] = "google-translate1.p.rapidapi.com"
    request.body = "q=#{q}&target=sk&source=en"

    res = JSON.parse(http.request(request).read_body)
    puts res
    if res["data"]
      res["data"]["translations"][0]["translatedText"]
    else
      ""
    end
  end
end
