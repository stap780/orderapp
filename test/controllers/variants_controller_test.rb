require 'test_helper'

class VariantsControllerTest < ActionController::TestCase
  setup do
    @variant = variants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:variants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create variant" do
    assert_difference('Variant.count') do
      post :create, variant: { cost_price: @variant.cost_price, old_price: @variant.old_price, price: @variant.price, product_id: @variant.product_id, quantity: @variant.quantity, sku: @variant.sku, variant_inid: @variant.variant_inid, weight: @variant.weight }
    end

    assert_redirected_to variant_path(assigns(:variant))
  end

  test "should show variant" do
    get :show, id: @variant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @variant
    assert_response :success
  end

  test "should update variant" do
    patch :update, id: @variant, variant: { cost_price: @variant.cost_price, old_price: @variant.old_price, price: @variant.price, product_id: @variant.product_id, quantity: @variant.quantity, sku: @variant.sku, variant_inid: @variant.variant_inid, weight: @variant.weight }
    assert_redirected_to variant_path(assigns(:variant))
  end

  test "should destroy variant" do
    assert_difference('Variant.count', -1) do
      delete :destroy, id: @variant
    end

    assert_redirected_to variants_path
  end
end
