# frozen_string_literal: true

class RailsGraphqlTutorialSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
