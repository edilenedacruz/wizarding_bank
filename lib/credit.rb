require './lib/bank'
require './lib/person'
require 'pry'

class Credit
  attr_reader :name, :accounts, :credit_limit
  def initialize(name)
    @name = name
    @accounts = Hash.new
  end

  def open_credit(person, credit_limit, interest_rate)
    accounts[person.name] = [credit_limit, interest_rate]
  end

  def cc_spend(person, purchase)
    if purchase > accounts[person.name][0]
      "Purchase declined."
    else
    accounts[person.name][0] -= purchase
    end
  end

  def cc_payment(person, payment)
    if payment > person.level_of_cash
      "Insufficient amount of cash."
    else
    accounts[person.name][0] += payment
    end
  end
end
