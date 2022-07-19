class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @authors = Author.all.page(params[:page])
  end

  def show
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: t(:'notice.author.created') }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: t(:'notice.author.updated') }
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
      format.html { redirect_to authors_url, notice: t(:'notice.author.deleted') }
      format.json { head :no_content }
    end
  end

  def correct_user
    @author = current_user.authors.find_by(id: params[:id])
    redirect_to books_path, alert: t(:'notice.not_authorized') if @author.nil?
  end

  private

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:first_name, :last_name, :country)
    end
end
