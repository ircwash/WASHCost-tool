require 'test_helper'

class SanitationBasicControllerTest < ActionController::TestCase

  test "should get country" do
    get :country
    assert_response :success
  end

  test "should get household" do
    get :household
    assert_response :success
  end

  test "should get latrine" do
    get :latrine
    assert_response :success
  end

  test "should get capital" do
    get :capital
    assert_response :success
  end

  test "should get recurrent" do
    get :recurrent
    assert_response :success
  end

  test "should get providing" do
    get :providing
    assert_response :success
  end

  test "should get impermeability" do
    get :impermeability
    assert_response :success
  end

  test "should get environment" do
    get :environment
    assert_response :success
  end

  test "should get usage" do
    get :usage
    assert_response :success
  end

  test "should get reliability" do
    get :reliability
    assert_response :success
  end

end
