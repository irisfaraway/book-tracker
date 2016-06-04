require 'test_helper'

# Tests for users
class UsersControllerTest < ActionController::TestCase
  setup do
    # Get user fixtures
    @admin_user = users(:admin_user)
    @create_user = users(:create_user)
    @show_user = users(:show_user)
    @edit_user = users(:edit_user)
    @update_user = users(:update_user)
    @destroy_user = users(:destroy_user)

    # Set current user
    session[:user_id] = @admin_user.id
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post :create, id: @create_user, user: { name: 'Julie Andrews' }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test 'should show user' do
    get :show, id: @update_user
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @edit_user
    assert_response :success
  end

  test 'should update user' do
    patch :update, id: @update_user, user: { provider: @show_user.provider,
                                             uid: @show_user.uid,
                                             name: @show_user.name,
                                             token: @show_user.token,
                                             expires_at: @show_user.expires_at,
                                             admin: @show_user.admin }
    assert_redirected_to user_path(assigns(:user))
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete :destroy, id: @destroy_user
    end

    assert_redirected_to users_path
  end
end
