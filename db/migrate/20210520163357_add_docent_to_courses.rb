class AddDocentToCourses < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :docent, foreign_key: true
  end
end
