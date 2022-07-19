class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    #@reviews = Review.all.page(params[:page])
    @reviews = Review.where(user_id: current_user.id).page(params[:page])
  end

  def show
  end

  def new
    @review = current_user.reviews.build
    @reading_records = ReadingRecord.where(user_id: current_user.id, status: "read")
    @book_ids = @reading_records.collect(&:book_id)
    @books = Book.where(id: @book_ids)
    @book_to_review =  Book.where(id: params[:book_to_review])
  end

  def edit
  end

  def create

    s_params = strong_params
    s_params[:reviewed_at] = Time.now
    @review = current_user.reviews.build(s_params)

    if Review.where(user_id: s_params[:user_id], book_id: s_params[:book_id]).first != nil
      redirect_to reviews_url, alert: "#{t(:'notice.reviews.already_reviewed')} `#{@review.book.title}`"
    else
      respond_to do |format|
        if @review.save

          format.html { redirect_to root_url, notice: t(:'notice.reviews.created') }
          format.json { render :show, status: :created, location: @review }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(author_params)
        format.html { redirect_to author_url(@review), notice: t(:'notice.reviews.updated') }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: t(:'notice.reviews.deleted') }
      format.json { head :no_content }
    end
  end

  def correct_user
    @author = current_user.authors.find_by(id: params[:id])
    redirect_to books_path, alert: t(:'notice.not_authorized') if @author.nil?
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def strong_params
    params.require(:review).permit(:user_id, :book_id, :score, :body, :reviewed_at)
  end
end