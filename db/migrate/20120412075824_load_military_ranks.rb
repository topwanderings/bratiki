require "active_record/fixtures"
class LoadMilitaryRanks < ActiveRecord::Migration
  def up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "military_ranks")
  end

  def down
    MilitaryRank.delete_all
  end
end
