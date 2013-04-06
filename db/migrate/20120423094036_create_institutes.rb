class CreateInstitutes < ActiveRecord::Migration
  def up
    create_table :institutes do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :institutes
  end
end
