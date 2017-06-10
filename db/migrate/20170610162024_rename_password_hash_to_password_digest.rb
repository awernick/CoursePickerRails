class RenamePasswordHashToPasswordDigest < ActiveRecord::Migration
  def change
    rename_column :students, :password_hash, :password_digest
  end
end
