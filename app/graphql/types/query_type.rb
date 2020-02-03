# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :all_links, function: Resolvers::LinksSearch
  end
end
