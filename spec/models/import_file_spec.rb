# == Schema Information
#
# Table name: import_files
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'
RSpec.describe ImportFile, type: :model do
  let!(:file) { File.open(Rails.root.join('spec', 'data', 'cnab_example.txt')) }  
  context 'parsing lines of file and update data' do
    before do
      subject.file = file
      subject.save
      
    end

    it 'have name with time' do
      expect(subject.name.empty?).to be_falsy
    end

    it 'should build 21 lines' do
      expect(subject.import_file_lines.count).to  eql(21)
    end
  end
  
end
