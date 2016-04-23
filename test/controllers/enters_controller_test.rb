require 'test_helper'

class EntersControllerTest < ActionController::TestCase
  setup do
    @enter = enters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enter" do
    assert_difference('Enter.count') do
      post :create, enter: { date: @enter.date, description: @enter.description, number: @enter.number, total: @enter.total }
    end

    assert_redirected_to enter_path(assigns(:enter))
  end

  test "should show enter" do
    get :show, id: @enter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enter
    assert_response :success
  end

  test "should update enter" do
    patch :update, id: @enter, enter: { date: @enter.date, description: @enter.description, number: @enter.number, total: @enter.total }
    assert_redirected_to enter_path(assigns(:enter))
  end

  test "should destroy enter" do
    assert_difference('Enter.count', -1) do
      delete :destroy, id: @enter
    end

    assert_redirected_to enters_path
  end
end
