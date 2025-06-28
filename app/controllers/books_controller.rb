class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  def index
    @book = Book.new  
    @user = current_user 
    @books = Book.all  
  end

  def show
    @book_new = Book.new  
    @book = Book.find(params[:id]) 
    @user = @book.user  
  end

  def create
    @user = current_user 
    @books = Book.all
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book), notice: 'Book was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    book = Book.find(params[:id])
    redirect_to books_path unless book.user == current_user
  end
end
