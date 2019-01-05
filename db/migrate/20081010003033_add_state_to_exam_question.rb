class AddStateToExamQuestion < ActiveRecord::Migration
  def self.up
    add_column :exam_questions, :state, :string
  end

  def self.down
    remove_column :exam_questions, :state
  end
end
