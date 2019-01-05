class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text    :body,   :null => false 
      t.boolean :active, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
