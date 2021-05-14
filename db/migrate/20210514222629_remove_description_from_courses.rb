class RemoveDescriptionFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :description, :string
  end
end
