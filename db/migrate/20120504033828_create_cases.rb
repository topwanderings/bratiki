class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.text :note
      t.datetime :date_time
      t.integer :pair_id
      t.integer :task_id

      t.timestamps
    end
  end
end
