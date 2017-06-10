class AddUuidToSections < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    add_column :sections, :uuid, :uuid
  end
end
