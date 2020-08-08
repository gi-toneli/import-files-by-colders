class AddStatusToImportFile < ActiveRecord::Migration[6.0]
  def change
    add_column :import_files, :status, :integer, defaut: 0
  end
end
