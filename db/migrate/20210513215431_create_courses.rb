class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :code
      t.integer :price
      t.string :enrollment_deadline

      t.timestamps
    end
  end
end
