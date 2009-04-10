require File.dirname(__FILE__) + '/../test_helper'

class MessageStoriesTest < ActionController::IntegrationTest
	def test_browsing_messages
		get "/"
		assert_response :success
		assert_template "index"
	end

	def test_creating_message
		post_via_redirect '/messages/new', :message => { :email => "some@email.com", :subject => "subject", :body => "body" }

		assert_response :success
	end
end
