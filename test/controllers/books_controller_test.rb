require 'test_helper'

# Tests for books
class BooksControllerTest < ActionController::TestCase
  setup do
    @finished_book = books(:finished_book)
    @unfinished_book = books(:unfinished_book)
    @delete_book = books(:delete_book)
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
      post :create, id: @unfinished_book, book: { user_id: @admin_user.id,
                                                  title: @unfinished_book.title,
                                                  author: @unfinished_book.author,
                                                  start_date: @unfinished_book.start_date,
                                                  end_date: @unfinished_book.end_date,
                                                  rating: @unfinished_book.rating,
                                                  number_of_pages: @unfinished_book.number_of_pages }
    end

    assert_redirected_to books_path
  end

  test 'should show book' do
    get :show, id: @unfinished_book
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @unfinished_book
    assert_response :success
  end

  test 'should update book' do
    patch :update, id: @unfinished_book, book: { user_id: @finished_book.user_id,
                                                 title: @finished_book.title,
                                                 author: @finished_book.author,
                                                 start_date: @finished_book.start_date,
                                                 end_date: @finished_book.end_date,
                                                 rating: @finished_book.rating,
                                                 number_of_pages: @finished_book.number_of_pages }
    assert_redirected_to books_path
  end

  test 'should destroy book' do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @delete_book
    end

    assert_redirected_to books_path
  end
end
