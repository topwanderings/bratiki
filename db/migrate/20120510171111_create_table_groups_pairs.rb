class CreateTableGroupsPairs < ActiveRecord::Migration
  def up
    create_table :groups_pairs, :id => false do |t|
      t.integer :group_id
      t.integer :pair_id
    end
  end

  def down
    drop_table :groups_pairs
  end
end
