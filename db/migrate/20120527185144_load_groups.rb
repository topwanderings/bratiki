require "active_record/fixtures"
class LoadGroups < ActiveRecord::Migration
  def up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "groups")
  end

  def down
    Group.delete_all
  end
end




