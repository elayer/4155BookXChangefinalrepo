class BooksController < ApplicationController
  def index
    @books = Book.where(:user_id => current_user.id)
    #@books = Book.search(params[:search])
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
      
    redirect_to books_path
  end
end

private
  def book_params
    params.require(:book).permit(:title, :author, :description, :progress, :search)
  end
