class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text    :body,        :null => false 
      t.boolean :correct,     :null => false, :default => false
      t.integer :question_id, :null => false 

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
