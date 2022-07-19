class HomeController < ApplicationController
  def index
  end

  def explore
    if params[:search] && (params[:search].length > 0)
      @can_reset = true
    end

    @books = Book.search(params[:search])
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
