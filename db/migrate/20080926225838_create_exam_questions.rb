class CreateExamQuestions < ActiveRecord::Migration
  def self.up
    create_table :exam_questions do |t|
      t.integer :exam_id,     :null => false 
      t.integer :question_id, :null => false 
      t.boolean :answer1,     :null => false, :default => false
      t.boolean :answer2,     :null => false, :default => false
      t.boolean :answer3,     :null => false, :default => false
      t.boolean :answer4,     :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :exam_questions
  end
end
