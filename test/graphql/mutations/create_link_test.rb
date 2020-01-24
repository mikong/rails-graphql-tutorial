# frozen_string_literal: true

require 'test_helper'

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateLink
      .new(object: nil, field: nil, context: { current_user: user })
      .resolve(args)
  end

  test 'create a new link' do
    user = create(:user)

    link = perform(
      url: 'http://example.com',
      description: 'Typical example URL',
      user: user,
    )

    assert link.persisted?
    assert_equal link.url, 'http://example.com'
    assert_equal link.description, 'Typical example URL'
  end
end
