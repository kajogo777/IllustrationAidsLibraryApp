require 'test_helper'

class ManageAidsControllerTest < ActionController::TestCase
  test "should get mpeople" do
    get :mpeople
    assert_response :success
  end

  test "should get mitems" do
    get :mitems
    assert_response :success
  end

  test "should get mcategories" do
    get :mcategories
    assert_response :success
  end

  test "should get mtags" do
    get :mtags
    assert_response :success
  end

  test "should get mservices" do
    get :mservices
    assert_response :success
  end

  test "should get mrequests" do
    get :mrequests
    assert_response :success
  end

  test "should get mcheckouts" do
    get :mcheckouts
    assert_response :success
  end

end
