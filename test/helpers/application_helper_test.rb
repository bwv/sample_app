require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

	def setup
		@base = "Ruby on Rails Tutorial Sample App"
	end

	test "full title helper" do 
		assert_equal full_title, "#{@base}"
		assert_equal full_title("Help"), "Help | #{@base}"
	end
end