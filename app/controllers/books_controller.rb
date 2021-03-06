class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.search(params[:search])
    if @books.class == Array
      @books = Kaminari.paginate_array(@books).page(params[:page])
    else
      @books = @books.page(params[:page])
    end
  end

  def show
    @book_reviews = Review.where(book_id: params[:id])
  end

  def new
    @book = Book.new
    @current_authors_options = Author.all
  end

  def edit
    @current_authors_options = Author.all
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: t(:'notice.book.created') }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: t(:'notice.book.updated') }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: t(:'notice.book.deleted') }
      format.json { head :no_content }
    end
  end

  def correct_user
    @book = Book.find_by_id(params[:id])
    @author = current_user.authors.find_by(id: @book.author_id)
    redirect_to authors_path, alert: t(:'notice.not_authorized') if @book.nil? || @author.nil?
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :title_sk, :isbn, :author_id)
  end
end