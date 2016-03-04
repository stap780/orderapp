require 'test_helper'

class PurchaseInvoiceInsControllerTest < ActionController::TestCase
  setup do
    @purchase_invoice_in = purchase_invoice_ins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_invoice_ins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_invoice_in" do
    assert_difference('PurchaseInvoiceIn.count') do
      post :create, purchase_invoice_in: { data: @purchase_invoice_in.data, number: @purchase_invoice_in.number, purchase_list_id: @purchase_invoice_in.purchase_list_id }
    end

    assert_redirected_to purchase_invoice_in_path(assigns(:purchase_invoice_in))
  end

  test "should show purchase_invoice_in" do
    get :show, id: @purchase_invoice_in
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_invoice_in
    assert_response :success
  end

  test "should update purchase_invoice_in" do
    patch :update, id: @purchase_invoice_in, purchase_invoice_in: { data: @purchase_invoice_in.data, number: @purchase_invoice_in.number, purchase_list_id: @purchase_invoice_in.purchase_list_id }
    assert_redirected_to purchase_invoice_in_path(assigns(:purchase_invoice_in))
  end

  test "should destroy purchase_invoice_in" do
    assert_difference('PurchaseInvoiceIn.count', -1) do
      delete :destroy, id: @purchase_invoice_in
    end

    assert_redirected_to purchase_invoice_ins_path
  end
end
