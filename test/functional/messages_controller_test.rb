require File.dirname(__FILE__) + '/../test_helper'

class MessagesControllerTest < ActionController::TestCase
	def setup
		@message1 = Factory.create(:message)
		@message2 = Factory.create(:message)
	end

  test "should get active" do
    get :index
		
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get trash" do
    get :trash

    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, :message => Factory.attributes_for(:message)
    end

    assert_redirected_to messages_url
  end

  test "should get edit" do
    get :edit, :id => @message2.to_param

    assert_response :success
  end

  test "should update message" do
    put :update, :id => @message1.to_param, :message => { :subject => "test" }

		assert_redirected_to messages_url
  end

	test "should update message and predifined text should appear on index page" do
		new_unique_body = "New_unique_body"
    put :update, :id => @message1.to_param, :message => { :subject => new_unique_body }

		get :index

		assert_select 'body', /#{new_unique_body}/, "Index page must contain #{new_unique_body} after update"
	end
	
  test "should move message to trash" do
    assert_difference('Message.active.count', -1) do
			assert_difference('Message.trash.count', +1) do
				delete :destroy, :id => @message1.to_param
			end
    end

    assert_redirected_to messages_url
  end

	test "should restore message from trash" do
		@trashed_message = Factory.create(:message, :in_trash => true)
    assert_difference('Message.active.count', +1) do
			assert_difference('Message.trash.count', -1) do
				put :update, :id => @trashed_message.to_param, :message => { :in_trash => false }
			end
    end

    assert_redirected_to messages_url
  end

	test "should delete trashed message forever" do
		@trashed_message = Factory.create(:message, :in_trash => true)
		assert_difference('Message.all.count', -1) do
			delete :destroy, :id => @trashed_message.to_param
		end
		
		assert_redirected_to trash_messages_url
	end

	test "should search by message subject and search result page should contain searched text" do
		@unique_message = Factory.create(:message, :subject => "unique_subj")
		post :search, :q => "que_s"

    assert_response :success
    assert_not_nil assigns(:messages)
		assert_equal 1, assigns(:messages).length, "Only one unique message must be found"
		assert_equal @unique_message, assigns(:messages)[0], "Only unique message must be found"
	end
end
