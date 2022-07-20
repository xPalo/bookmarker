class HomeController < ApplicationController
  def index
  end

  def quote
    @quote = Quote.last
  end


  def explore
    if (params[:search] && (params[:search].length > 0)) || (params[:order] && (params[:order].length > 0))
      @can_reset = true
    end

    puts "\n\n\n\n\nEXPLORE BEGAN\n\n\n\n\n\n"

    @books = Book.includes(:author).search(params[:search])
    if params[:order] && (params[:order].length > 0)
      case params[:order]
      when "title_asc"
        @books = @books.order("title ASC")
      when "title_desc"
        @books = @books.order("title DESC")

      when "sk_title_asc"
        @books = @books.order("title_sk ASC")
      when "sk_title_desc"
        @books = @books.order("title_sk DESC")

      when "rating_asc"
        @books = @books.sort_by { |b| -b.comparison_rating }
      when "rating_desc"
        @books = @books.sort_by { |b| b.comparison_rating }

      when "reviews_asc"
        @books = @books.sort_by { |b| -b.comparison_ratings }
      when "reviews_desc"
        @books = @books.sort_by { |b| b.comparison_ratings }

      else
        flash[:alert] = t(:'order.invalid_value')
      end
    end

    if @books.class == Array
      @books = Kaminari.paginate_array(@books).page(params[:books_page])
    else
      @books = @books.page(params[:books_page])
    end

    @authors = Author.all.page(params[:authors_page])
    @users = User.all.page(params[:users_page])
  end

  def change_locale
    lang = params[:locale].to_s.strip.to_sym
    lang = I18n.default_locale unless I18n.available_locales.include?(lang)
    cookies[:lang] = lang
    redirect_to request.referer || root_url
  end
end
