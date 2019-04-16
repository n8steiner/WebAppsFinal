class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :identifier
      t.string :description
      t.integer :credit_hours

      t.timestamps
    end
  end
end
