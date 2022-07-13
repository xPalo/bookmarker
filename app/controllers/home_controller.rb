class HomeController < ApplicationController
  def index
  end

  def explore
    @books = Book.reorder("title").includes(:author).page(params[:page])
    @authors = Author.reorder("first_name").page(params[:page])
  end
end
