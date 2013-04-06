class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.references :student
      t.references :pair
      t.string :mark

      t.timestamps
    end
    add_index :grades, :student_id
    add_index :grades, :pair_id
  end
end
