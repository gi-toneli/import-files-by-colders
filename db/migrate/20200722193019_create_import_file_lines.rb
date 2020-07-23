class CreateImportFileLines < ActiveRecord::Migration[6.0]
  def change
    create_table :import_file_lines do |t|
      t.string :line
      t.integer :transaction_type
      t.date :date_occurency
      t.float :value
      t.string :cpf
      t.string :card
      t.time :occurency_hour
      t.string :owner
      t.string :store_name
      t.timestamps
    end
  end
end
