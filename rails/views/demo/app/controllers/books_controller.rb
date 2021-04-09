class BooksController < ApplicationController
  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by(id: params[:id])
    if @book
      render :show
    else
      redirect_to books_url
    end
  end

  def new
    @book = Book.new
    render :new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_url(@book.id)
    else
      render :new
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
    render :edit
  end

  def update
    @book = Book.find_by(id: params[:id])
    if @book.update_attributes(book_params)
      redirect_to book_url(@book)
    else
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :year, :category, :description)
  end
end