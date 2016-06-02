require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, book: { user_id: @book.user_id,
                            title: @book.title,
                            author: @book.author,
                            start_date: @book.start_date,
                            end_date: @book.end_date,
                            rating: @book.rating,
                            number_of_pages: @book.number_of_pages
                          }
    end

    assert_redirected_to books_path
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book
    assert_response :success
  end

  test "should update book" do
    patch :update, id: @book, book: { user_id: @book.user_id,
                                      title: @book.title,
                                      author: @book.author,
                                      start_date: @book.start_date,
                                      end_date: @book.end_date,
                                      rating: @book.rating,
                                      number_of_pages: @book.number_of_pages
                                    }
    assert_redirected_to books_path
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end
end
