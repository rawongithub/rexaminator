class AddIndexesToDatabase < ActiveRecord::Migration
  def self.up
    add_index :answers, :question_id

    add_index :categories_questions, :category_id
    add_index :categories_questions, :question_id

    add_index :exam_questions, :exam_id
    add_index :exam_questions, :question_id
  end

  def self.down
    remove_index :answers, :question_id

    remove_index :categories_questions, :category_id
    remove_index :categories_questions, :question_id
    
    remove_index :exam_questions, :exam_id
    remove_index :exam_questions, :question_id
    
  end
end
