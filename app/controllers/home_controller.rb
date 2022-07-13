class HomeController < ApplicationController
  def index
  end

  def explore
    @books = Book.all.includes(:author).page(params[:page])
    @authors = Author.all.page(params[:page])
  end
end
