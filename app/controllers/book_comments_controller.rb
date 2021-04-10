class BookCommentsController < ApplicationController

  def show
    @book = Book.find(params[:book_id])
    @book_new = Book.new
    @book_comment = BookComment.new
    # @book_comments = @book.book_comments
  end
  
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save!
      # redirect_back(fallback_location: book_path(book))
    # else
      # redirect_back(fallback_location: book_path(book))
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end