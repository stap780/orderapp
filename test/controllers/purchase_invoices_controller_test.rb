require 'test_helper'

class PurchaseInvoicesControllerTest < ActionController::TestCase
  setup do
    @purchase_invoice = purchase_invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_invoice" do
    assert_difference('PurchaseInvoice.count') do
      post :create, purchase_invoice: { company_id: @purchase_invoice.company_id, date: @purchase_invoice.date, number: @purchase_invoice.number, total_price: @purchase_invoice.total_price }
    end

    assert_redirected_to purchase_invoice_path(assigns(:purchase_invoice))
  end

  test "should show purchase_invoice" do
    get :show, id: @purchase_invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_invoice
    assert_response :success
  end

  test "should update purchase_invoice" do
    patch :update, id: @purchase_invoice, purchase_invoice: { company_id: @purchase_invoice.company_id, date: @purchase_invoice.date, number: @purchase_invoice.number, total_price: @purchase_invoice.total_price }
    assert_redirected_to purchase_invoice_path(assigns(:purchase_invoice))
  end

  test "should destroy purchase_invoice" do
    assert_difference('PurchaseInvoice.count', -1) do
      delete :destroy, id: @purchase_invoice
    end

    assert_redirected_to purchase_invoices_path
  end
end
