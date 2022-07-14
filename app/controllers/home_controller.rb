class HomeController < ApplicationController
  def index
  end

  def explore
    #@books = Book.reorder("title").includes(:author).page(params[:page])

    @books = Book.search(params[:search])
    if @books.class == Array
      @books = Kaminari.paginate_array(@books).page(params[:page])
    else
      @books = @books.page(params[:page])
    end

    @authors = Author.all.page(params[:page])
    @users = User.all.page(params[:page])
  end
end
