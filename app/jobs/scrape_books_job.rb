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
        begin
          # AUTHOR
          author_url = listing.css("a.ContributorLink")[0].attributes["href"].value
          unparsed_author_page = HTTParty.get(author_url)

          unless unparsed_author_page.body.nil?
            parsed_author_page = Nokogiri::HTML(unparsed_author_page)

            author = {
              first_name: first_name(parsed_author_page.css("h1.authorName").css("span[itemprop='name']").text),
              last_name: last_name(parsed_author_page.css("h1.authorName").css("span[itemprop='name']").text),
              country: trim_country(parsed_author_page.css("div.dataTitle")[0].next_sibling.text.strip)
            }

            a = nil
            if (author[:first_name] && author[:first_name].length > 0) && (author[:last_name] && author[:last_name].length > 0)

              a = Author.where(first_name: author[:first_name], last_name: author[:last_name]).first_or_create(first_name: author[:first_name], last_name: author[:last_name], country: author[:country])
              authors << author

            end

            puts "AUTHOR FIRST NAME: #{author[:first_name]}"
            puts "AUTHOR LAST NAME: #{author[:last_name]}"
            puts "AUTHOR COUNTRY: #{author[:country]}"
          end

          # BOOK
          book_url = listing.css("h3.Text a[data-testid='bookTitle']")[0].attributes["href"].value
          unparsed_book_page = HTTParty.get(book_url)

          unless unparsed_book_page.body.nil?
            parsed_book_page = Nokogiri::HTML(unparsed_book_page)

            book = {}
            if a != nil
              book = {
                title: parsed_book_page.css("h1#bookTitle").text.strip,
                title_sk: parsed_book_page.css("h1#bookTitle").text.strip,
                isbn: get_isbn(parsed_book_page),
                author_id: a.id
              }
            end

            b = nil
            if book[:title] && book[:title].length > 0
              b = Book.where(title: book[:title], author_id: a.id).first_or_create(title: book[:title], title_sk: book[:title_sk], isbn: book[:isbn], author_id: a.id)
              books << book
            end

            puts "BOOK TITLE: #{book[:title]}"
            puts "BOOK TITLE_SK: #{book[:title_sk]}"
            puts "BOOK ISBN: #{book[:isbn]}"
            puts "BOOK AUTHOR ID: #{book[:author_id]}"
          end
        rescue
          next
        end

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
    begin
      if country.start_with?("in ")
        country[3..-1]
      else
        country
      end
    rescue
      "-"
    end
  end

  def get_isbn(page)
    begin
      if page.css("div.infoBoxRowTitle")[0].text.upcase && (page.css("div.infoBoxRowTitle")[0].text.upcase == "ISBN")
        page.css("div.infoBoxRowItem")[0].text.split.first
      else
        "-"
      end
    rescue
      "-"
    end
  end
end

# src="https://storage1.premiumcdn.net/preview/31438115/A0VfKmF18CpzUk8IwQc4jI9Aiw5fZ0iZpIqkuENIg6C4PINYTGqIe0uk7CZpT7KF8msdauR3t68HpRfl1txdFXRi8Yib5UOPteXcQrha1tdwt0DtlxtJPU3Gs1JH2BUl5tmwFwlt63tZKs7js0G.mp4?expires=1658507117&hash=yX9nQ4iQlz7WbDEyfrhXbw"
# src="https://storage1.premiumcdn.net/preview/31438115/A0VfKmF18CpzUk8IwQc4jI9Aiw5fZ0iZpIqkuENIg6C4PINYTGqIe0uk7CZpT7KF8msdauR3t68HpRfl1txdFXRi8Yib5UOPteXcQrha1tdwt0DtlxtJPU3Gs1JH2BUl5tmwFwlt63tZKs7js0G.mp4?expires=1658507117&hash=yX9nQ4iQlz7WbDEyfrhXbw"