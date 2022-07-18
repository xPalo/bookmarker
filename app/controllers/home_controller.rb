class HomeController < ApplicationController
  def index
  end

  def explore
    #@books = Book.reorder("title").includes(:author).page(params[:page])

    @books = Book.search(params[:search])
    if @books.class == Array
      @books = Kaminari.paginate_array(@books).page(params[:books_page])
    else
      @books = @books.page(params[:books_page])
    end

    @authors = Author.all.page(params[:authors_page])
    @users = User.all.page(params[:users_page])
  end
end
