class AddOriginalTitleIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :movies, :originalTitle, order: { name: :varchar_pattern_ops }
  end
end
