class BooksController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_book, only: [:show, :edit, :update, :destroy]
  # before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @books = Book.all.paginate(page: params[:page], per_page: 10)
    # @books = Book.all.page(params[:page]).per(10)
  end

  def show
    @book = Book.find_by(id: params[:id])
    return if @book.present?

    render json: { error: 'Book not found' }, status: 404
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Book was successfully created.'
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])

    if @book.update(book_params)
      flash[:success] = 'Book was successfully updated:)'
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    flash[:success] = 'Book was successfully destroyed.'
    redirect_to books_path
  end

  def search
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).page(params[:page]).per(10)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author_name, :isbn, :genre, :number_of_books, :published_year, :image)
  end

  def authorize_user!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user && current_user.admin?
  end
end
