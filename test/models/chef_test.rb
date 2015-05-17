require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(name: "Johnny", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef name should be present" do
    @chef.name = ""
    assert_not @chef.valid?
  end

  test "chef email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validaion should accept valid addresses" do
    emails = %w[joe@yahoo.com same@wheaton.edu laurajdesoto@gmail.com]
    emails.each do |va|
      @chef.email = va
      #assert @chef.valid?, va+ " should be valid email"
      assert @chef.valid?, '#{va.inspect} should be valid email'
    end
  end

  test "email validation should reject invalid addresses" do
    emails = %w[joe @wheaton.edu 1234]
    emails.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, ia + ' should be invalid email'
    end
  end
  

end
