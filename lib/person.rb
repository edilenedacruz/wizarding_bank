class Person
  attr_reader :name
  attr_accessor :level_of_cash
  def initialize(name, level_of_cash)
    @name = name
    @level_of_cash = level_of_cash
  end

  def create_person
    "#{name} has been created with #{level_of_cash} galleons in cash."
  end
end
