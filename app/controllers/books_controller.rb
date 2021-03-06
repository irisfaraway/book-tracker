class BooksController < ApplicationController
  require 'googlebooks'
  before_action :check_if_logged_in
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_editing_permissions, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    # List the user's books, starting with unfinished ones and then most recently finished
    @books = Book.where(user_id: current_user.id).order('end_date IS NOT NULL, end_date DESC, start_date DESC')
    count_finished_and_in_progress_books
    calculate_average_reading_time
    calculate_average_book_ratings
    count_pages_read
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

  # Use callbacks to share common setup or constraints between actions
  def set_book
    @book = Book.find(params[:id])
  end

  # Check if the user is logged in and redirect them if not
  def check_if_logged_in
    return if logged_in?
    flash[:notice] = 'You need to log in first'
    redirect_to(root_path)
  end

  # Check if the user is allowed to view, edit or delete a book
  def check_editing_permissions
    return if @book.user.id == current_user.id || current_user.admin?
    flash[:warning] = "You can't edit someone else's book"
    redirect_to(books_path)
  end

  # Calculate book stats for dashboard
  def count_finished_and_in_progress_books
    # Count how many books were finished this year
    @finished_this_year = @books.where('end_date > ?', Time.zone.today.beginning_of_year).count
    # Count how many books are still being read
    @in_progress = @books.where('end_date IS NULL').count
  end

  # Average time it took to read each book this year
  def calculate_average_reading_time
    if @finished_this_year.nonzero?
      # Gets number of current day in entire year, divides it by number of books with end dates this year
      @days_per_book = Time.zone.today.yday / @finished_this_year
      # TODO: get actual number of days in year to avoid dodgy leap year stats
      @books_per_year = 365 / @days_per_book
    else
      @days_per_book = 0
    end
  end

  # Average book ratings this year and overall
  def calculate_average_book_ratings
    @average_this_year = if @books.rated_this_year.empty?
                           0
                         else
                           @books.started_this_year.average('rating').round(1)
                         end
    @average_overall = if @books.rated.empty?
                         0
                       else
                         @books.average('rating').round(1)
                       end
  end

  # Count number of pages read this year and overall
  def count_pages_read
    @page_count_this_year = @books.finished_this_year_and_has_pages.sum('number_of_pages')
    @page_count_overall = @books.finished_and_has_pages.sum('number_of_pages')
  end

  # Search Google Books and return results
  def search_google_books
    @google_books_results = GoogleBooks.search(params[:google_books_query], country: 'uk')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title,
                                 :author,
                                 :number_of_pages,
                                 :start_date,
                                 :end_date,
                                 :rating)
  end
end
