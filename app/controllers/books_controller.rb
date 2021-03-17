class BooksController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end
  
  private
  def
  params.require(:book).permit(:title, :body, :image)
  
end
