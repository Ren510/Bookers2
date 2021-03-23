class UsersController < ApplicationController
  def index
   
  end

  def new
    @post_image = PostImage.new
  end
  def show
    @users = User.all 
    @book = Book.new
    @user = current_user
    @post_images = @user.books
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
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end