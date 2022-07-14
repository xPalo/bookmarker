class HomeController < ApplicationController
  def index
  end

  def explore
    @books = Book.reorder("title").includes(:author).page(params[:page])
    @authors = Author.all.page(params[:page])
    @users = User.all.page(params[:page])
  end
end
