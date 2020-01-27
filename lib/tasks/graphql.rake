# frozen_string_literal: true

require 'graphql/rake_task'

GraphQL::RakeTask.new(
  schema_name: 'RailsGraphqlTutorialSchema',
  dependencies: [:environment],
  directory: Rails.root.join('app/graphql'),
)
