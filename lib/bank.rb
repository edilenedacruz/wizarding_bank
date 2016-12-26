require_relative 'person'

class Bank
  attr_reader :bank_name, :accounts
  def initialize(bank_name)
    @bank_name = bank_name
    @accounts = {}
  end

  def create_bank
    "#{bank_name} has been created."
  end

  def open_account(person)
    accounts[person.name] = 0
    "An account has been opened for #{person.name} with #{bank_name}."
  end

  def deposit(person, deposit)
    if deposit > person.level_of_cash
      "#{person.name} does not have enough cash to perform this deposit."
    else
      accounts[person.name] += deposit
      person.level_of_cash -= deposit
      "#{deposit} galleons have been deposited into #{person.name}'s #{bank_name} account. Balance: #{deposit} Cash: #{person.level_of_cash}"
    end
  end

  def withdrawal(person, withdrawal)
    if withdrawal > accounts[person.name]
      "Insufficient funds."
    else
      accounts[person.name] -= withdrawal
      person.level_of_cash += withdrawal
      "#{person.name} has withdrawn #{withdrawal} galleons. Balance: #{accounts[person.name] -= withdrawal}"
    end
  end

  def transfer(person, other_bank, amount)
    if other_bank.accounts[person.name] == nil
      "#{person.name} does not have an account with #{other_bank.bank_name}."
    elsif
      amount > accounts[person.name]
      "Insufficient funds."
    else
      accounts[person.name] -= amount
      other_bank.accounts[person.name] += amount
      "#{person.name} has transferred #{amount} galleons from #{bank_name} to #{other_bank.bank_name}."
    end
  end

  def total_cash
  	total = accounts.values.reduce(:+)
    "Total Cash: #{total} galleons"
  end
end
