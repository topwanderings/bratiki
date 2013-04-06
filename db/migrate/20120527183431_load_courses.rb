require "active_record/fixtures"
class LoadCourses < ActiveRecord::Migration
  def up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    ActiveRecord::Fixtures.create_fixtures(directory, "courses")
  end

  def down
    Course.delete_all
  end
end




