class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_user_to_like, only: [:like]

  def index
    @users = User.where.not(id: current_user.id).page(params[:page])
  end

  def show
  end

  def like
    UsersMailer.like(@user, @author, @book).deliver_now
  end

  private

  def set_user
    @user = User.where(id: params[:id])
  end

  def set_user_to_like
    @book = Book.where(id: params[:id]).first
    @author = @book.author
    @user = @author.user
  end


end
