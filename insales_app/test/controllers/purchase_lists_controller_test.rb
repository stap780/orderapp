require 'test_helper'

class PurchaseListsControllerTest < ActionController::TestCase
  setup do
    @purchase_list = purchase_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_list" do
    assert_difference('PurchaseList.count') do
      post :create, purchase_list: { company_id: @purchase_list.company_id, date: @purchase_list.date, number: @purchase_list.number, total_price: @purchase_list.total_price }
    end

    assert_redirected_to purchase_list_path(assigns(:purchase_list))
  end

  test "should show purchase_list" do
    get :show, id: @purchase_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_list
    assert_response :success
  end

  test "should update purchase_list" do
    patch :update, id: @purchase_list, purchase_list: { company_id: @purchase_list.company_id, date: @purchase_list.date, number: @purchase_list.number, total_price: @purchase_list.total_price }
    assert_redirected_to purchase_list_path(assigns(:purchase_list))
  end

  test "should destroy purchase_list" do
    assert_difference('PurchaseList.count', -1) do
      delete :destroy, id: @purchase_list
    end

    assert_redirected_to purchase_lists_path
  end
end
