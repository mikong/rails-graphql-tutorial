# frozen_string_literal: true

module Types
  class LinkType < Types::BaseObject
    field :id, ID, null: false
    field :url, String, null: false
    field :description, String, null: true
    field :posted_by, UserType, null: false, method: :user
    field :votes, [Types::VoteType], null: false
  end
end
