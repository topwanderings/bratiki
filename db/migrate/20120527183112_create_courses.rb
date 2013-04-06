class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :number
      t.references :faculty

      t.timestamps
    end
    add_index :courses, :faculty_id
  end
end
