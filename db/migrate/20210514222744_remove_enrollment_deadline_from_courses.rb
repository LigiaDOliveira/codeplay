class RemoveEnrollmentDeadlineFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :enrollment_deadline, :string
  end
end
