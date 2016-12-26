require_relative 'test_helper'
require './lib/credit'

class CreditTest < Minitest::Test
  def test_credit_company_has_name
    amex = Credit.new("AMEX")
    assert_equal "AMEX", amex.name
  end

  def test_when_line_is_open_it_pass_a_person_limit_and_interest_rate
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 1000)
    amex.open_credit(person1, 100, 0.05)
    assert_equal "Minerva", amex.accounts.keys[0]
    assert_equal 100, amex.accounts[person1.name][0]
    assert_equal 0.05, amex.accounts[person1.name][1]
  end

  def test_a_person_can_spend_against_their_credit_limit
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 1000)
    amex.open_credit(person1, 1000, 0.05)
    amex.cc_spend(person1, 50)
    assert_equal 950, amex.accounts[person1.name][0]
  end

  def test_person_cannot_spend_more_than_their_credit_limit
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 1000)
    amex.open_credit(person1, 1000, 0.05)
    assert_equal "Purchase declined.", amex.cc_spend(person1, 1500)
  end

  def test_a_person_can_pay_down_their_credit_balance
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 1000)
    amex.open_credit(person1, 1000, 0.05)
    amex.cc_spend(person1, 500)
    amex.cc_payment(person1, 500)
    assert_equal 1000, amex.accounts[person1.name][0]
  end

  def test_person_should_not_be_able_to_pay_down_balance_with_more_than_their_cash_on_hand
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 400)
    amex.open_credit(person1, 1000, 0.05)
    amex.cc_spend(person1, 500)
    assert_equal "Insufficient amount of cash.", amex.cc_payment(person1, 500)
  end

end
