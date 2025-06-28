class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  def index
    @book = Book.new 
    @user = current_user  
    @users = User.all
  end

  def show
    @book = Book.new  
    @user = User.find(params[:id])
    @books = @user.books  
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user), notice: 'User was successfully updated.' 
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    redirect_to user_path(current_user) unless user == current_user
  end
end
