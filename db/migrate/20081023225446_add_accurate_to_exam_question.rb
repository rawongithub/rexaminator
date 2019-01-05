class AddAccurateToExamQuestion < ActiveRecord::Migration
  def self.up
    add_column :exam_questions, :accurate, :boolean
  end

  def self.down
    remove_column :exam_questions, :accurate
  end
end
