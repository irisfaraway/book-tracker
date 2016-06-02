require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin_user)
    @normal_user = users(:normal_user)
    session[:user_id] = @admin.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, id: @admin, user: { name: 'Julie Andrews' }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @admin, user: { name: 'Drimble Wedge' }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @normal_user
    end

    assert_redirected_to users_path
  end
end
