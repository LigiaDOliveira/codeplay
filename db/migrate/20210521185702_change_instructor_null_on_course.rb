class ChangeInstructorNullOnCourse < ActiveRecord::Migration[6.1]
  def change
    change_column_null :courses, :docent_id, false
  end
end
