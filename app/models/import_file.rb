# == Schema Information
#
# Table name: import_files
#
#  id          :bigint           not null, primary key
#  count_lines :integer          default(0)
#  file_name   :string           not null
#  name        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ImportFile < ApplicationRecord
  attr_accessor :file
  has_many :import_file_lines

  after_initialize :set_name
  before_validation :save_file
  after_create :perfom_lines
  enum status: [ :processing, :finished ]

  protected
    def set_name
      self.name = "CNAB - #{Time.now}"
    end

    def save_file
      unless self.file
        self.errors.add(:file, 'You must fill the file')
        return false
      end
      self.file_name = Rails.root.join('public','uploads',"#{Time.now}-#{self.file.original_filename}")
      File.open(self.file_name, 'wb') do |file|
        file.write(self.file.read)
      end
      true
    end

    def perfom_lines
      ImportFileJob.perform_later(self.id)
    end
end
