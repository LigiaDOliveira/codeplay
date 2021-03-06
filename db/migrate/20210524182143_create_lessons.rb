class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :duration
      t.text :body
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
end
