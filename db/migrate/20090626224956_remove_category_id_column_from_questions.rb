class RemoveCategoryIdColumnFromQuestions < ActiveRecord::Migration
  def self.up
    remove_column :questions, :category_id
  end

  def self.down
    add_column :questions, :category_id, :integer
  end
end
