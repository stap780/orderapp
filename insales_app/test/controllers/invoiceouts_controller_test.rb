require 'test_helper'

class InvoiceoutsControllerTest < ActionController::TestCase
  setup do
    @invoiceout = invoiceouts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoiceouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoiceout" do
    assert_difference('Invoiceout.count') do
      post :create, invoiceout: { company_id: @invoiceout.company_id, date: @invoiceout.date, invoice_list_id: @invoiceout.invoice_list_id, nds: @invoiceout.nds, number: @invoiceout.number, payment: @invoiceout.payment, total_price: @invoiceout.total_price }
    end

    assert_redirected_to invoiceout_path(assigns(:invoiceout))
  end

  test "should show invoiceout" do
    get :show, id: @invoiceout
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoiceout
    assert_response :success
  end

  test "should update invoiceout" do
    patch :update, id: @invoiceout, invoiceout: { company_id: @invoiceout.company_id, date: @invoiceout.date, invoice_list_id: @invoiceout.invoice_list_id, nds: @invoiceout.nds, number: @invoiceout.number, payment: @invoiceout.payment, total_price: @invoiceout.total_price }
    assert_redirected_to invoiceout_path(assigns(:invoiceout))
  end

  test "should destroy invoiceout" do
    assert_difference('Invoiceout.count', -1) do
      delete :destroy, id: @invoiceout
    end

    assert_redirected_to invoiceouts_path
  end
end
