require 'rails_helper'
RSpec.describe ImportFile, type: :model do
  let!(:file) { File.open(Rails.root.join('spec', 'data', 'cnab_example.txt')) }
  context 'validating attributes' do
    it 'should be invalid' do
      expect(subject.valid?).to be_falsy
      expect(subject.errors.size).to eql(1)
    end

    it 'should be valid' do
      expect(subject.file.attach(io: file, filename: 'test.txt')).to be_truthy
      expect(subject.valid?).to be_truthy
    end
  end
  
  context 'parsing lines of file and update data' do
    before do
      subject.file.attach(io: file, filename: 'test.txt')
      # subject.save
    end

    it 'have name with time' do
      expect(subject.name.empty?).to be_falsy
    end

  # it 'should build 21 lines' do
  #   expect(subject.import_file_lines.count).to  eql(21)
  # end
  end
  
end
