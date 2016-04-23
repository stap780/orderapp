require 'test_helper'

class InvoiceListsControllerTest < ActionController::TestCase
  setup do
    @invoice_list = invoice_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoice_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice_list" do
    assert_difference('InvoiceList.count') do
      post :create, invoice_list: { client_id: @invoice_list.client_id, company_id: @invoice_list.company_id, date: @invoice_list.date, number: @invoice_list.number, status: @invoice_list.status, total_price: @invoice_list.total_price }
    end

    assert_redirected_to invoice_list_path(assigns(:invoice_list))
  end

  test "should show invoice_list" do
    get :show, id: @invoice_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice_list
    assert_response :success
  end

  test "should update invoice_list" do
    patch :update, id: @invoice_list, invoice_list: { client_id: @invoice_list.client_id, company_id: @invoice_list.company_id, date: @invoice_list.date, number: @invoice_list.number, status: @invoice_list.status, total_price: @invoice_list.total_price }
    assert_redirected_to invoice_list_path(assigns(:invoice_list))
  end

  test "should destroy invoice_list" do
    assert_difference('InvoiceList.count', -1) do
      delete :destroy, id: @invoice_list
    end

    assert_redirected_to invoice_lists_path
  end
end
