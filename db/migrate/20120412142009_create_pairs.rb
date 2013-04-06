class CreatePairs < ActiveRecord::Migration
  def up
    create_table :pairs do |t|
      t.references :subject
      t.string :pair_type
      t.integer :pair_number
      t.references :teacher
      t.datetime :date_time
      t.string :place

      t.timestamps
    end
    add_index :pairs, :teacher_id
  end

  def down
    drop_table :pairs
  end
end
