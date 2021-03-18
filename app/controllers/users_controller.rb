class UsersController < ApplicationController
  def show
    @user = User.find(1)
    @post_images = @user.books
  end
  
  def create
     @user = User.new(user_params)
      @user.image = "default_icon.jpg"
    if @user.save
      redirect_to posts_path, success: 'You have created book successfully.'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
   def edit
    @user = User.find(1)
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
    
  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end