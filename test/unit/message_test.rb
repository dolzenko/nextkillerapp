require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < ActiveSupport::TestCase
	def test_invalid_with_empty_attributes
		message = Message.new
		assert !message.valid?
		assert message.errors.invalid?(:email)
	end

	def test_invalid_email
		message = Message.new
		message.email = "not an email address"
		assert !message.valid?
		assert message.errors.invalid?(:email)
	end

	def test_valid_email
		message = Message.new
		message.email = "all.good@email.address.com"
		assert message.valid?
	end

	def test_by_default_active_messages
		message1 = Factory.create(:message)
		message2 = Factory.create(:message)
		assert_equal 2, Message.active.length
	end

	def test_trash_scope
		message1 = Factory.create(:message, :in_trash => true)
		message2 = Factory.create(:message, :in_trash => true)
		assert_equal 0, Message.active.length
		assert_equal 2, Message.trash.length
	end
end
