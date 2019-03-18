require "application_system_test_case"

module Dps::Engine
  class Admin::Users::ArticlesTest < ApplicationSystemTestCase
    setup do
      @admin_users_article = dps_engine_admin_users_articles(:one)
    end

    test "visiting the index" do
      visit admin_users_articles_url
      assert_selector "h1", text: "Admin/Users/Articles"
    end

    test "creating a Article" do
      visit admin_users_articles_url
      click_on "New Admin/Users/Article"

      fill_in "Title", with: @admin_users_article.title
      click_on "Create Article"

      assert_text "Article was successfully created"
      click_on "Back"
    end

    test "updating a Article" do
      visit admin_users_articles_url
      click_on "Edit", match: :first

      fill_in "Title", with: @admin_users_article.title
      click_on "Update Article"

      assert_text "Article was successfully updated"
      click_on "Back"
    end

    test "destroying a Article" do
      visit admin_users_articles_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Article was successfully destroyed"
    end
  end
end
