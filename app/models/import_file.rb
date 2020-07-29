# == Schema Information
#
# Table name: import_files
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ImportFile < ApplicationRecord
  attr_accessor :lines, :file
  has_many :import_file_lines

  after_initialize :set_name, :set_lines
  after_create :build_import_file_lines


  protected
    def set_name
      self.name = "CNAB - #{Time.now}"
    end

    def set_lines
      self.lines = []
    end

    def build_import_file_lines
      File.readlines(self.file).each do |line|
        line = line[0..80]
        import_file_line = self.import_file_lines.build(line: line)
        import_file_line.save
      end
    end
end
