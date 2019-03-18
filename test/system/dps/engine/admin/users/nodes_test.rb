require "application_system_test_case"

module Dps::Engine
  class Admin::Users::NodesTest < ApplicationSystemTestCase
    setup do
      @admin_users_node = dps_engine_admin_users_nodes(:one)
    end

    test "visiting the index" do
      visit admin_users_nodes_url
      assert_selector "h1", text: "Admin/Users/Nodes"
    end

    test "creating a Node" do
      visit admin_users_nodes_url
      click_on "New Admin/Users/Node"

      fill_in "Title", with: @admin_users_node.title
      click_on "Create Node"

      assert_text "Node was successfully created"
      click_on "Back"
    end

    test "updating a Node" do
      visit admin_users_nodes_url
      click_on "Edit", match: :first

      fill_in "Title", with: @admin_users_node.title
      click_on "Update Node"

      assert_text "Node was successfully updated"
      click_on "Back"
    end

    test "destroying a Node" do
      visit admin_users_nodes_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Node was successfully destroyed"
    end
  end
end
