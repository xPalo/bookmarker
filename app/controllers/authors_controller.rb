class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    #@authors = current_user.authors.page(params[:page])
    @author = Author.all
  end

  def show
  end

  def new
    @author = current_user.authors.build
  end

  def edit
  end

  def create
    @author = current_user.authors.build(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: "Author was successfully created." }
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

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:first_name, :last_name, :country, :user_id)
    end
end
