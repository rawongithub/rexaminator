class CreateCategoriesQuestions < ActiveRecord::Migration
  def self.up
    puts 'start'
    create_table :categories_questions, :id => false do |t|
      t.integer :question_id, :null => false
      t.integer :category_id, :null => false
    end
  end

  def self.down
    drop_table :categories_questions
  end
end

