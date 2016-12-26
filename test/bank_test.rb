require_relative 'test_helper'
require './lib/bank'
require './lib/person'

class BankTest < Minitest::Test
  def test_bank_has_a_name
    chase = Bank.new("JP Morgan Chase")
    assert_equal "JP Morgan Chase has been created.", chase.create_bank
  end

  def test_it_can_create_another_bank
    wells_fargo = Bank.new("Wells Fargo")
    assert_equal "Wells Fargo has been created.", wells_fargo.create_bank
  end

  def test_it_opens_an_account_to_a_person
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    assert_equal "An account has been opened for Minerva with JP Morgan Chase.", chase.open_account(person1)
  end

  def test_when_deposit_is_made_persons_cash_level_decrease_and_acct_balance_increase
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    assert_equal "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250", chase.deposit(person1, 750)
  end

  def test_person_should_not_be_able_to_deposit_more_than_their_current_level_of_cash
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    assert_equal "Minerva does not have enough cash to perform this deposit.", chase.deposit(person1, 5000)
  end

  def test_banks_can_do_withdrawals
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    chase.deposit(person1, 750)
    assert_equal "Minerva has withdrawn 250 galleons. Balance: 250", chase.withdrawal(person1, 250)
  end

  def test_person_cant_withdraw_more_than_they_have
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    assert_equal "Insufficient funds.", chase.withdrawal(person1, 25000)
  end

  def test_it_can_transfer_money_to_another_bank
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    chase.open_account(person1)
    chase.deposit(person1, 750)
    wells_fargo = Bank.new("Wells Fargo")
    wells_fargo.open_account(person1)
    assert_equal "Minerva has transferred 250 galleons from JP Morgan Chase to Wells Fargo.", chase.transfer(person1, wells_fargo, 250)
  end

  def test_person_cant_transfer_more_than_they_have
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    chase.open_account(person1)
    chase.deposit(person1, 750)
    wells_fargo = Bank.new("Wells Fargo")
    wells_fargo.open_account(person1)
    assert_equal "Insufficient funds.", chase.transfer(person1, wells_fargo, 25000)
  end

  def test_person_cant_transfert_to_bank_they_dont_have_accounts
    person1 = Person.new("Luna", 500)
    chase = Bank.new("JP Morgan Chase")
    chase.open_account(person1)
    chase.deposit(person1, 750)
    wells_fargo = Bank.new("Wells Fargo")
    assert_equal "Luna does not have an account with Wells Fargo.", chase.transfer(person1, wells_fargo, 250)
  end

  def test_total_balance_in_bank_is_known
    person1 = Person.new("Minerva", 1000)
    person2 = Person.new("Luna", 1500)
    chase = Bank.new("JP Morgan Chase")
    chase.open_account(person1)
    chase.deposit(person1, 250)
    chase.open_account(person2)
    chase.deposit(person2, 500)
    assert_equal "Total Cash: 750 galleons", chase.total_cash
  end

end
