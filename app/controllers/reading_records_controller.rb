class ReadingRecordsController < ApplicationController
  before_action :set_reading_record, only: [:show, :edit, :update, :destroy, :mark_as_read, :mark_as_reading]
  before_action :can_manipulate?, only: %i[ edit update destroy create new mark_as_read mark_as_reading ]
  before_action :authenticate_user!

  def mark_as_reading
    s_params = Hash.new
    s_params[:user_id] = @reading_record.user_id
    s_params[:book_id] = @reading_record.book_id
    s_params[:status] = 1
    s_params[:finished_reading_at] = nil

    if @reading_record.update(s_params)
      respond_to do |format|
        format.html { redirect_to reading_records_url, notice: t(:'notice.records.marked_as_reading') }
        format.json { render :show, status: :ok, location: @reading_record }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @reading_record.errors, status: :unprocessable_entity }
    end
  end

  def mark_as_read
    s_params = Hash.new
    s_params[:user_id] = @reading_record.user_id
    s_params[:book_id] = @reading_record.book_id
    s_params[:status] = 2
    s_params[:finished_reading_at] = Time.now

    if @reading_record.update(s_params)
      respond_to do |format|
        format.html { redirect_to reading_records_url, notice: t(:'notice.records.marked_as_read') }
        format.json { render :show, status: :ok, location: @reading_record }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @reading_record.errors, status: :unprocessable_entity }
    end
  end

  def index
    @reading_records = ReadingRecord.includes(:book).where(user_id: current_user.id)
    @read = @reading_records.where(status: "read").page(params[:page])
    @reading = @reading_records.where(status: "reading").page(params[:page])
    @plan_to_read = @reading_records.where(status: "plan_to_read").page(params[:page])
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
      redirect_to reading_records_url, alert: "#{t(:'notice.records.already_keeping_track')} `#{@reading_record.book.title}`"
    else
      respond_to do |format|
        if @reading_record.save
          format.html { redirect_to reading_record_url(@reading_record), notice: t(:'notice.records.created') }
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
      if @reading_record.update(strong_params)
        format.html { redirect_to author_url(@reading_record), notice: t(:'notice.records.updated') }
        format.json { render :show, status: :ok, location: @reading_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reading_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reading_record.destroy

    respond_to do |format|
      format.html { redirect_to authors_url, notice: t(:'notice.records.deleted') }
      format.json { head :no_content }
    end
  end

  private

  def can_manipulate?
    redirect_to reading_records_path, notice: t(:not_authorized) unless @reading_record.user_id == current_user.id || current_user.is_admin
  end

  def set_reading_record
    @reading_record = ReadingRecord.find(params[:id])
  end

  def strong_params
    params.require(:reading_record).permit(:user_id, :book_id, :status, :finished_reading_at)
  end
end