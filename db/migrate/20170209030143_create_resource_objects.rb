class CreateResourceObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_objects do |t|
      t.string :foreign_class_name
      t.integer :foreign_id

      t.timestamps
    end
  end
end
