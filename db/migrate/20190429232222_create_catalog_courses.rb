class CreateCatalogCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :catalog_courses do |t|
      t.references :catalog, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
