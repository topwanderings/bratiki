require "active_record/fixtures"
  class LoadRoles < ActiveRecord::Migration
  def up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "roles")
  end

  def down
    Role.delete_all
  end
end



