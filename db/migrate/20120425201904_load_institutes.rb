require "active_record/fixtures"
class LoadInstitutes < ActiveRecord::Migration
  def up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "institutes")
  end

  def down
    Institute.delete_all
  end
end


