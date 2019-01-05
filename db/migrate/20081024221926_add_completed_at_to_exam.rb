class AddCompletedAtToExam < ActiveRecord::Migration
  def self.up
    add_column :exams, :completed_at, :datetime
  end

  def self.down
    remove_column :exams, :completed_at
  end
end
