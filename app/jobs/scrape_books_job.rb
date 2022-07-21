class ScrapeBooksJob < ApplicationJob
  queue_as :default
  require "nokogiri"
  require "httparty"

  def perform(*args)
    base_url = "https://www.goodreads.com/book"
    current_year = Time.now.year
    current_month = Time.now.month

    url = "#{base_url}/popular_by_date/#{current_year}/#{current_month}"
    unparsed_page = HTTParty.get(url)

    unless unparsed_page.body.nil?
      parsed_page = Nokogiri::HTML(unparsed_page)

      books = Array.new
      authors = Array.new
      book_listings = parsed_page.css("article.BookListItem")

      book_listings.each do |listing|

        # AUTHOR
        # author_url = listing.css("a.ContributorLink")[0].attributes["href"].value
        # unparsed_author_page = HTTParty.get(author_url)
        #
        # unless unparsed_author_page.body.nil?
        #   parsed_author_page = Nokogiri::HTML(unparsed_author_page)
        #
        #   author = {
        #     first_name: first_name(parsed_author_page.css("h1.authorName").css("span[itemprop='name']").text),
        #     last_name: last_name(parsed_author_page.css("h1.authorName").css("span[itemprop='name']").text),
        #     country: trim_country(parsed_author_page.css("div.dataTitle")[0].next_sibling.text.strip)
        #   }
        #
        #   authors << author
        #   puts "AUTHOR FIRST NAME: #{author[:first_name]}"
        #   puts "AUTHOR LAST NAME: #{author[:last_name]}"
        #   puts "AUTHOR COUNTRY: #{author[:country]}"
        # end

        # BOOK
        book_url = listing.css("h3.Text a[data-testid='bookTitle']")[0].attributes["href"].value
        unparsed_book_page = HTTParty.get(book_url)

        unless unparsed_book_page.body.nil?
          parsed_book_page = Nokogiri::HTML(unparsed_book_page)

          book = {
            title: parsed_book_page.css("h1#bookTitle").text.strip,
            title_sk: parsed_book_page.css("h1#bookTitle").text.strip,
            isbn: get_isbn(parsed_book_page),
            author_id: ""
          }

          books << book
          puts "BOOK TITLE: #{book[:title]}"
          puts "BOOK TITLE_SK: #{book[:title_sk]}"
          puts "BOOK ISBN: #{book[:isbn]}"
          puts "BOOK AUTHOR ID: #{book[:author_id]}"
        end

        # puts "BOOK TITLE: #{listing.css("h3.Text a[data-testid='bookTitle']").text}"
      end

      puts "ALL AUTHORS: #{authors}"
      puts "ALL BOOKS: #{books}"
    end
  end

  def first_name(name)
    if name.split.count > 1
      name.split[0..-2].join(' ')
    else
      name
    end
  end

  def last_name(name)
    if name.split.count > 1
      name.split.last
    end
  end

  def trim_country(country)
    if country.start_with?("in ")
      country[3..-1]
    else
      country
    end
  end

  def get_isbn(page)
    if page.css("div.infoBoxRowTitle")[0].text.upcase == "ISBN"
      page.css("div.infoBoxRowTitle")[0].next_sibling&.text
    else
      "-"
    end
  end
end
