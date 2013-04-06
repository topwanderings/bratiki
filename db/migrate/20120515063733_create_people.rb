class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :type
      t.references :sex
      t.references :military_rank
      t.references :scientific_rank
      t.references :scientific_degree
      t.references :post
      t.references :chair
      t.references :group
      t.references :course
      t.string :telephone
      t.string :room

      t.timestamps
    end
    add_index :people, :sex_id
    add_index :people, :military_rank_id
    add_index :people, :scientific_rank_id
    add_index :people, :scientific_degree_id
    add_index :people, :post_id
    add_index :people, :group_id
    add_index :people, :chair_id
    add_index :people, :course_id
  end
end
