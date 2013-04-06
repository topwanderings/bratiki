class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user
      t.string :name
      t.boolean :status
      t.string :type
      t.references :task

      t.timestamps
      t.datetime :completed_at
    end
    add_index :tasks, :user_id
    add_index :tasks, :task_id
  end
end
