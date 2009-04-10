class FixDefaultsForMessagesColumns < ActiveRecord::Migration
	class Message < ActiveRecord::Base; end

  def self.up
		change_column_default(:messages, :in_trash, 0)
		Message.update_all("in_trash = 0", "in_trash IS NULL")
		change_column_default(:messages, :important, 0)
		Message.update_all("important = 0", "important IS NULL")
  end

  def self.down
  end
end
