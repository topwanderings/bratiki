class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string :number
      t.references :chair
      t.references :course

      t.timestamps
    end
    add_index :groups, :chair_id
  end

  def down
    drop_table :groups
  end
end
