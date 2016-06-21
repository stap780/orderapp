require 'test_helper'

class GstelesControllerTest < ActionController::TestCase
  setup do
    @gstele = gsteles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gsteles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gstele" do
    assert_difference('Gstele.count') do
      post :create, gstele: { cost_price: @gstele.cost_price, price: @gstele.price, quantity: @gstele.quantity, sku: @gstele.sku, title: @gstele.title, valute: @gstele.valute }
    end

    assert_redirected_to gstele_path(assigns(:gstele))
  end

  test "should show gstele" do
    get :show, id: @gstele
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gstele
    assert_response :success
  end

  test "should update gstele" do
    patch :update, id: @gstele, gstele: { cost_price: @gstele.cost_price, price: @gstele.price, quantity: @gstele.quantity, sku: @gstele.sku, title: @gstele.title, valute: @gstele.valute }
    assert_redirected_to gstele_path(assigns(:gstele))
  end

  test "should destroy gstele" do
    assert_difference('Gstele.count', -1) do
      delete :destroy, id: @gstele
    end

    assert_redirected_to gsteles_path
  end
end
