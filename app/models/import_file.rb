class ImportFile < ApplicationRecord
  has_one_attached :file
  validates :file, :name, presence: true
  has_many :import_file_lines
end
