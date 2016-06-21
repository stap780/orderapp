require 'test_helper'

class ProductOptionsControllerTest < ActionController::TestCase
  setup do
    @product_option = product_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_option" do
    assert_difference('ProductOption.count') do
      post :create, product_option: { opt_name_inid: @product_option.opt_name_inid, opt_value_inid: @product_option.opt_value_inid, title: @product_option.title }
    end

    assert_redirected_to product_option_path(assigns(:product_option))
  end

  test "should show product_option" do
    get :show, id: @product_option
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_option
    assert_response :success
  end

  test "should update product_option" do
    patch :update, id: @product_option, product_option: { opt_name_inid: @product_option.opt_name_inid, opt_value_inid: @product_option.opt_value_inid, title: @product_option.title }
    assert_redirected_to product_option_path(assigns(:product_option))
  end

  test "should destroy product_option" do
    assert_difference('ProductOption.count', -1) do
      delete :destroy, id: @product_option
    end

    assert_redirected_to product_options_path
  end
end
