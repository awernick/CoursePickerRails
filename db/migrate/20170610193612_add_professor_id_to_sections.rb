class AddProfessorIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :professor_id, :integer
    add_index :sections, :professor_id
  end
end
