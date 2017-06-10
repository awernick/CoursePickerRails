class AddDefaultGeneratorForSectionsUuid < ActiveRecord::Migration
  def change
    change_column_default :sections, :uuid, "uuid_generate_v4()"
  end
end
