class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def following
    @user = User.find(params[:id])
    @users = @user.followeds.page(params[:page])
    render 'following'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'followers'
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def new
    @post_image = PostImage.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def create
      @user = User.new(user_params)
      # @user.image = "default_icon.jpg"
    if @user.save
      NotificationMailer.send_confirm_to_user(@user).deliver
      # flash[:notice] = "Welcome! You have signed up successfully.."
      redirect_to @user
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
       flash[:notice] = "You have updated user successfully."
    else
      @books = Book.all
      render :edit
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
     redirect_to user_path(current_user)
    end
  end
end
