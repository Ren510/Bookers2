class UsersController < ApplicationController
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
    if  @user.save
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(@user)
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