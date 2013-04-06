require "active_record/fixtures"
class LoadDocuments < ActiveRecord::Migration
  def up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "documents")
  end

  def down
    Document.delete_all
  end
end




