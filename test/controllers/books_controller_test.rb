require 'test_helper'

# Tests for books
class BooksControllerTest < ActionController::TestCase
  setup do
    # Get the book fixtures
    @create_book = books(:create_book)
    @show_book = books(:show_book)
    @edit_book = books(:edit_book)
    @update_book = books(:update_book)
    @destroy_book = books(:destroy_book)

    # Set user and session
    @admin_user = users(:admin_user)
    session[:user_id] = @admin_user.id
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post :create, id: @create_book, book: { title: @create_book.title,
                                              author: @create_book.author,
                                              start_date: @create_book.start_date,
                                              end_date: @create_book.end_date,
                                              rating: @create_book.rating,
                                              user_id: @create_book.user_id,
                                              number_of_pages: @create_book.number_of_pages }
    end

    assert_redirected_to books_path
  end

  test 'should show book' do
    get :show, id: @show_book
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @edit_book
    assert_response :success
  end

  test 'should update book' do
    patch :update, id: @update_book, book: { title: @update_book.title,
                                             author: @update_book.author,
                                             start_date: @update_book.start_date,
                                             end_date: @update_book.end_date,
                                             rating: @update_book.rating,
                                             user_id: @update_book.user_id,
                                             number_of_pages: @update_book.number_of_pages }
    assert_redirected_to books_path
  end

  test 'should destroy book' do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @destroy_book
    end

    assert_redirected_to books_path
  end
end
