# frozen_string_literal: true

require 'test_helper'

class Mutations::CreateVoteTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateVote
      .new(object: nil, field: nil, context: { current_user: user })
      .resolve(args)
  end

  def create_link
    author = create(:user)
    create(:link, user: author)
  end

  test 'create a new vote' do
    user = create(:user)
    link = create_link

    vote = perform(
      link_id: link.id,
      user: user,
    )

    assert vote.persisted?
    assert_equal vote.link.id, link.id
  end
end
