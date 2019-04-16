class CreatePlanCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :plan_courses do |t|
      t.references :plan, foreign_key: true
      t.references :course, foreign_key: true
      t.string :term
      t.integer :year

      t.timestamps
    end
  end
end
