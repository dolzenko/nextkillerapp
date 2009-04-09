class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :email
      t.string :subject
      t.text :body
      t.boolean :in_trash
      t.boolean :important

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
