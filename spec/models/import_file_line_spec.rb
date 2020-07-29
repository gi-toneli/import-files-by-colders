# == Schema Information
#
# Table name: import_file_lines
#
#  id               :bigint           not null, primary key
#  card             :string
#  cpf              :string
#  date_occurency   :date
#  line             :string
#  occurency_hour   :time
#  owner            :string
#  store_name       :string
#  transaction_type :integer
#  value            :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  import_file_id   :bigint
#
# Indexes
#
#  index_import_file_lines_on_import_file_id  (import_file_id)
#
require 'rails_helper'

RSpec.describe ImportFileLine, type: :model do
  let!(:line) { '5201903010000013200556418150633123****7687145607MARIA JOSEFINALOJA DO Ó - MATRIZ' }
  context 'get parts of string' do
    it 'should return a valid part of string' do
      subject.line = line
      expect(subject.parse_line(0, 0)).to eql('5')
      expect(subject.parse_line(1, 8)).to eql('20190301')
      expect(subject.parse_line(9, 18)).to eql('0000013200')
      expect(subject.parse_line(48, 61)).to eql('MARIA JOSEFINA')
    end
  end

  context 'subject should return attributes of line' do
    before do
      subject.line = line
      subject.valid?
    end

    it 'have lenght 8 for line attributes' do
      expect(subject.set_attributes.size).to eql(8)
    end

    it 'line have a correctly size' do
      expect(subject.line.size).to eql(80)
    end

    it 'valid transaction_type' do
      expect(subject.transaction_type).to eql('Recebimento Empréstimo')
    end

    it 'valid date_occurency' do
      expect(subject.date_occurency).to eql('20190301'.to_date)
    end

    it 'valid value' do
      expect(subject.value).to eql(132.0)
    end

    it 'valid cpf' do
      expect(subject.cpf).to eql('55641815063')
    end

    it 'valid card' do
      expect(subject.card).to eql('3123****7687')
    end

    it 'valid occurency_hour' do
      expect(subject.occurency_hour.hour).to eql(14)
      expect(subject.occurency_hour.min).to eql(56)
      expect(subject.occurency_hour.sec).to eql(7)
    end

    it 'valid owner' do
      expect(subject.owner).to eql('MARIA JOSEFINA')
    end

    it 'valid store_name' do
      expect(subject.store_name).to eql('LOJA DO Ó - MATRIZ')
    end
  end
end
