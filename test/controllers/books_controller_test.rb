require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @finished_book = books(:finished_book)
    @admin_user = users(:admin_user)
    session[:user_id] = @admin_user.id
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
      post :create, id: @finished_book, book: { user_id: @admin_user.id,
                            title: @finished_book.title,
                            author: @finished_book.author,
                            start_date: @finished_book.start_date,
                            end_date: @finished_book.end_date,
                            rating: @finished_book.rating,
                            number_of_pages: @finished_book.number_of_pages
                          }
    end

    assert_redirected_to books_path
  end

  test "should show book" do
    get :show, id: @finished_book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @finished_book
    assert_response :success
  end

  test "should update book" do
    patch :update, id: @finished_book, book: { user_id: @finished_book.user_id,
                                               title: @finished_book.title,
                                               author: @finished_book.author,
                                               start_date: @finished_book.start_date,
                                               end_date: @finished_book.end_date,
                                               rating: @finished_book.rating,
                                               number_of_pages: @finished_book.number_of_pages
                                             }
    assert_redirected_to books_path
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @finished_book
    end

    assert_redirected_to books_path
  end
end
