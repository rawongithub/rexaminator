class UpdateQuestions < ActiveRecord::Migration
  def self.up
    change_column :questions, :category_id, :integer, :null => false
  end

  def self.down
    change_column :questions, :category_id, :integer
  end
end
