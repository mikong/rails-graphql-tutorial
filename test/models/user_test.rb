# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
      password_confirmation: 'password123',
    )
  end

  test 'should save valid user' do
    @user.save
    assert @user.persisted?
  end

  test 'should authenticate password' do
    @user.save
    refute @user.authenticate('notright')
    assert @user.authenticate('password123')
  end
end
