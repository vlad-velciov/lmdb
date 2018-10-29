class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :tconst
      t.string :titleType
      t.string :primaryTitle
      t.string :originalTitle
      t.integer :isAdult
      t.string :startYear
      t.string :endYear
      t.string :runtimeMinutes
      t.string :genres
    end
  end
end
