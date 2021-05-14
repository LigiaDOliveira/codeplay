class AddEnrollmentDeadlineToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :enrollment_deadline, :date
  end
end
