class RemoveDateAndTimeAndAddCorrectFields < ActiveRecord::Migration
  def change
    remove_column :sections, :date
    remove_column :sections, :time
    add_column :sections, :days, :integer
    add_column :sections, :start_time, :time
    add_column :sections, :end_time, :time
  end
end
