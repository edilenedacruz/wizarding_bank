require_relative 'test_helper'
require './lib/person'

class PersonTest < Minitest::Test
  def test_person_is_created_with_name_and_cash
    person1 = Person.new("Minerva", 1000)
    assert_equal "Minerva has been created with 1000 galleons in cash.", person1.create_person
  end

  def test_another_person_can_be_created_with_dif_name_and_cash_level
    person2 = Person.new("Luna", 500)
    assert_equal "Luna has been created with 500 galleons in cash.", person2.create_person
  end
end
