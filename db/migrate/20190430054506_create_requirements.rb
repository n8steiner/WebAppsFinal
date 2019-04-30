class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.references :major, foreign_key: true
      t.references :catalog, foreign_key: true

      t.timestamps
    end
  end
end
