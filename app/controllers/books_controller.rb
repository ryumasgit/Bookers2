class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      flash[:notice] = "An error created the book from being successfully created."
      render :index
    end
  end

  def index
    @book = Book.new
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.new
    @book.user_id = current_user.id
    @books = Book.find(params[:id])
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      flash[:notice] = "An error prevented the book from being successfully updated."
      render :edit
    end
  end

  def destroy
    books = Book.find(params[:id])
    if books.destroy
      redirect_to books_path
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
