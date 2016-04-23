require 'test_helper'

class RollbacksControllerTest < ActionController::TestCase
  setup do
    @rollback = rollbacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rollbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rollback" do
    assert_difference('Rollback.count') do
      post :create, rollback: {  }
    end

    assert_redirected_to rollback_path(assigns(:rollback))
  end

  test "should show rollback" do
    get :show, id: @rollback
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rollback
    assert_response :success
  end

  test "should update rollback" do
    patch :update, id: @rollback, rollback: {  }
    assert_redirected_to rollback_path(assigns(:rollback))
  end

  test "should destroy rollback" do
    assert_difference('Rollback.count', -1) do
      delete :destroy, id: @rollback
    end

    assert_redirected_to rollbacks_path
  end
end
