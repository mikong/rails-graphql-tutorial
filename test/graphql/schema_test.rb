# frozen_string_literal: true

require 'test_helper'

class SchemaTest < ActiveSupport::TestCase
  test 'GraphQL Schema dump is up-to-date' do
    schema_definition = RailsGraphqlTutorialSchema.to_definition
    schema_dump = File.read(Rails.root.join('app/graphql/schema.graphql'))
    assert_equal schema_definition, schema_dump
  end
end
