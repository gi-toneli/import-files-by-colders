class AddCountLinesToImportFile < ActiveRecord::Migration[6.0]
  def change
    add_column :import_files, :count_lines, :integer, default: 0
  end
end
