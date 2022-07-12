class ReadingRecordsController < ApplicationController
  before_action :set_reading_record, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    #@authors = current_user.authors.page(params[:page])
    @reading_records = current_user.reading_records.page(params[:page])
    @read = @reading_records.where(status: "read").length
    @reading = @reading_records.where(status: "reading").length
    @plan_to_read = @reading_records.where(status: "plan_to_read").length
  end

  def show
  end

  def new
    @reading_record = current_user.reading_records.build
    @books = Book.all
  end

  def edit
  end

  def create

    s_params = strong_params
    s_params[:finished_reading_at] = Time.now if s_params[:status] == "read"
    @reading_record = current_user.reading_records.build(s_params)

    if ReadingRecord.where(user_id: s_params[:user_id], book_id: s_params[:book_id]).first != nil
      redirect_to reading_records_url, alert: "You already keep track of the `#{@reading_record.book.title}`"
    else
      respond_to do |format|
        if @reading_record.save
          format.html { redirect_to reading_record_url(@reading_record), notice: "Record was successfully created." }
          format.json { render :show, status: :created, location: @reading_record }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @reading_record.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @author = current_user.authors.find_by(id: params[:id])
    redirect_to books_path, notice: "Not authorized to manipulate" if @author.nil?
  end

  private

  def set_reading_record
    @reading_record = ReadingRecord.find(params[:id])
  end

  def strong_params
    params.require(:reading_record).permit(:user_id, :book_id, :status, :finished_reading_at)
  end
end