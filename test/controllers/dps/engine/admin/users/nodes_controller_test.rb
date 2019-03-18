require 'test_helper'

module Dps::Engine
  class Admin::Users::NodesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @admin_users_node = dps_engine_admin_users_nodes(:one)
    end

    test "should get index" do
      get admin_users_nodes_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_users_node_url
      assert_response :success
    end

    test "should create admin_users_node" do
      assert_difference('Admin::Users::Node.count') do
        post admin_users_nodes_url, params: { admin_users_node: { title: @admin_users_node.title } }
      end

      assert_redirected_to admin_users_node_url(Admin::Users::Node.last)
    end

    test "should show admin_users_node" do
      get admin_users_node_url(@admin_users_node)
      assert_response :success
    end

    test "should get edit" do
      get edit_admin_users_node_url(@admin_users_node)
      assert_response :success
    end

    test "should update admin_users_node" do
      patch admin_users_node_url(@admin_users_node), params: { admin_users_node: { title: @admin_users_node.title } }
      assert_redirected_to admin_users_node_url(@admin_users_node)
    end

    test "should destroy admin_users_node" do
      assert_difference('Admin::Users::Node.count', -1) do
        delete admin_users_node_url(@admin_users_node)
      end

      assert_redirected_to admin_users_nodes_url
    end
  end
end
