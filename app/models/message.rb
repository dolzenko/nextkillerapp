class Message < ActiveRecord::Base
	named_scope :trash, :conditions => {:in_trash => true}
	named_scope :active, :conditions => {:in_trash => false}
	
	validates_presence_of :email
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
