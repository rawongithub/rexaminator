class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.boolean :active, :null => false, :default => true
      t.string  :category
      t.text    :body
      t.string  :author
      t.integer :question_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end

