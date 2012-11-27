require 'test_helper'

class GenerationsControllerTest < ActionController::TestCase
  setup do
    @generation = generations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generation" do
    assert_difference('Generation.count') do
      post :create, generation: { current: @generation.current }
    end

    assert_redirected_to generation_path(assigns(:generation))
  end

  test "should show generation" do
    get :show, id: @generation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generation
    assert_response :success
  end

  test "should update generation" do
    put :update, id: @generation, generation: { current: @generation.current }
    assert_redirected_to generation_path(assigns(:generation))
  end

  test "should destroy generation" do
    assert_difference('Generation.count', -1) do
      delete :destroy, id: @generation
    end

    assert_redirected_to generations_path
  end
end
