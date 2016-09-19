require 'test_helper'

class DoversControllerTest < ActionController::TestCase
  setup do
    @dover = dovers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dovers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dover" do
    assert_difference('Dover.count') do
      post :create, dover: { company_id: @dover.company_id, enddate: @dover.enddate, number: @dover.number, startdate: @dover.startdate, user_id: @dover.user_id }
    end

    assert_redirected_to dover_path(assigns(:dover))
  end

  test "should show dover" do
    get :show, id: @dover
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dover
    assert_response :success
  end

  test "should update dover" do
    patch :update, id: @dover, dover: { company_id: @dover.company_id, enddate: @dover.enddate, number: @dover.number, startdate: @dover.startdate, user_id: @dover.user_id }
    assert_redirected_to dover_path(assigns(:dover))
  end

  test "should destroy dover" do
    assert_difference('Dover.count', -1) do
      delete :destroy, id: @dover
    end

    assert_redirected_to dovers_path
  end
end
