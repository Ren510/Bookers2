class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

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
      @user.image = "default_icon.jpg"
    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully.."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    if params[:id] == current_user.id
    @user = User.find(params[:id])
    render action: :edit
    else
    @user = current_user
    render action: :show
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
       flash[:notice] = "You have updated book successfully."
    else
      @books = Book.all
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end