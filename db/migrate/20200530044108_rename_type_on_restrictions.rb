class RenameTypeOnRestrictions < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :restrictions, :type, :name
  end

  def self.down
    rename_column :restrictions, :name, :type
  end
end
