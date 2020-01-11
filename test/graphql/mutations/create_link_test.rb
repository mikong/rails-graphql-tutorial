# frozen_string_literal: true

require 'test_helper'

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(**args)
    Mutations::CreateLink
      .new(object: nil, field: nil, context: {})
      .resolve(args)
  end

  test 'create a new link' do
    link = perform(
      url: 'http://example.com',
      description: 'Typical example URL',
    )

    assert link.persisted?
    assert_equal link.url, 'http://example.com'
    assert_equal link.description, 'Typical example URL'
  end
end
