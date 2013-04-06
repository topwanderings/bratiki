class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.references :task
      t.string :entity
      t.string :name
      t.string :value
    end
    add_index :parameters, :task_id
  end
end
