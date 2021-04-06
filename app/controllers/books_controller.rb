class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
     @books = Book.all
     @book = Book.new
     @user = current_user
  end
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @book.user
    @books = Book.all
  end
  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if  @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end

end