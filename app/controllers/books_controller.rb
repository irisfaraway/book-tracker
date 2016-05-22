class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  require 'googlebooks'

  # GET /books
  # GET /books.json
  def index
    if logged_in?
      # List the user's books, starting with unfinished ones and then most recently finished
      @books = Book.where(user_id: current_user.id).order('end_date IS NOT NULL, end_date DESC, start_date DESC')
      # Book stats for dashboard
      @finished_this_year = @books.where('end_date > ?', Date.today.beginning_of_year).count
      if @finished_this_year.nonzero?
        # Gets number of current day in entire year, divides it by number of books with end dates this year
        @days_per_book = Date.today.yday / @finished_this_year
        # TODO: get actual number of days in year to avoid dodgy leap year stats
        @books_per_year = 365 / @days_per_book
      else
        @days_per_book = 0
      end
      @in_progress = @books.where('end_date IS NULL').count
      @average_this_year = @books.where('end_date >= ?', Date.today.beginning_of_year).average('rating').round(1)
      @average_overall = @books.average('rating').round(1)
    else
      flash[:notice] = "You need to log in first"
      redirect_to(root_path)
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    search_google_books
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    respond_to do |format|
      if @book.save
        format.html { redirect_to books_url, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_url, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
      unless @book.user.id == current_user.id
        flash[:warning] = "You can't edit someone else's book"
        redirect_to(books_path)
      end
    end

    # Search Google Books and return results
    def search_google_books
      @google_books_results = GoogleBooks.search('The Great Gatsby', {:country => "uk"})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title,
                                    :author,
                                    :start_date,
                                    :end_date,
                                    :rating,
                                    :query)
    end
end
