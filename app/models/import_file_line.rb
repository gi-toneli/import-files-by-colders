class ImportFileLine < ApplicationRecord
  attr_accessor :line
  validates :transaction_type, presence: true
  validates :value, presence: true, numericality: {only_float: true}
  validates :cpf, presence: true, length: {is: 11}
  validates :card, presence: true, length: {is: 12}

  validate :date_occurency_is_valid?, :occurency_hour_is_valid?,
    :owner_is_valid?, :store_name_is_valid?

  before_validation :set_attributes

  enum transaction_type:
    {
      'Débito': 1,
      'Boleto': 2,
      'Financiamento': 3,
      'Crédito': 4,
      'Recebimento Empréstimo': 5,
      'Vendas': 6,
      'Recebimento TED': 7,
      'Recebimento DOC': 8,
      'Aluguel': 9 
    }

  def set_attributes
    self.transaction_type = parse_line(0, 0).to_i
    self.date_occurency = parse_line(1, 8).to_s.to_date
    self.value = parse_line(9, 18).to_i / 100.00
    self.cpf = parse_line(19, 29)
    self.card = parse_line(30, 41)

    hour = parse_line(42, 43).to_s
    min = parse_line(44, 45).to_s
    sec = parse_line(46, 47).to_s
    if !hour.empty? && !min.empty? && !sec.empty?
      self.occurency_hour = DateTime.now.change({
        hour: hour.to_i,
        min: min.to_i,
        sec: sec.to_i,
        offset: 'Brasilia'
      })
    end

    self.owner = parse_line(48, 61).to_s.strip
    self.store_name = parse_line(62, 80).to_s.strip

    [transaction_type, date_occurency, value, cpf, card, occurency_hour, owner, store_name]
  end

  def parse_line(initial_position, end_position)
    self.line.to_s[initial_position..end_position]
  end

  protected
  def date_occurency_is_valid?
    if self.date_occurency && self.date_occurency.class == Date
      true
    else
      errors.add(:date_occurency, 'should be a Date')
    end
  end

  def occurency_hour_is_valid?
    if self.occurency_hour && self.occurency_hour.class == ActiveSupport::TimeWithZone
      true
    else
      errors.add(:occurency_hour, 'should be a Time')
    end
  end

  def owner_is_valid?
    if self.owner && self.owner.class == String && !self.owner.strip.empty?
      true
    else
      errors.add(:owner, "can't be blank")
    end
  end

  def store_name_is_valid?
    if self.store_name && self.store_name.class == String && !self.store_name.strip.empty?
      true
    else
      errors.add(:store_name, "can't be blank")
    end
  end
end
