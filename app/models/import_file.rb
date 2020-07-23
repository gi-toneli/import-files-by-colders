class ImportFile < ApplicationRecord
  validates :file, attached: true
  has_one_attached :file
  has_many :import_file_lines

  after_initialize :set_name
  after_create :build_import_file_lines

  protected
    def set_name
      self.name = "CNAB - #{Time.now}"
    end

    def build_import_file_lines
      File.readlines(self.file).each do |line|
        self.import_file_lines.build(line: line)
      end
    end

end
