class Message < ActiveRecord::Base
	validate :valid_email?

	named_scope :trash, :conditions => {:in_trash => true}
	
	def valid_email?
		TMail::Address.parse(email)
	rescue
		errors.add_to_base("Must be a valid email")
	end
end
