class AddFileNameToImportFile < ActiveRecord::Migration[6.0]
  def change
    add_column :import_files, :file_name, :string, null: false
  end
end
