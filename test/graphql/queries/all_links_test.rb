# frozen_string_literal: true

require 'test_helper'

class AllLinksTest < ActiveSupport::TestCase
  def create_link
    author = create(:user)
    create(:link, user: author)
  end

  test 'all links' do
    query_string = <<-GRAPHQL
      {
        allLinks {
          id
          url
          description
          createdAt
        }
      }
    GRAPHQL

    link = create_link

    result = RailsGraphqlTutorialSchema.execute(query_string)
    links_result = result['data']['allLinks']
    assert_equal links_result.size, 1

    item = links_result.first
    assert_equal item['url'], link.url

    create_date = Date.strptime(item['createdAt'], '%Y-%m-%d')
    assert create_date.today?
  end

  test 'all links has votes' do
    query_string = <<-GRAPHQL
      {
        allLinks {
          votes {
            id
          }
        }
      }
    GRAPHQL

    create_link

    result = RailsGraphqlTutorialSchema.execute(query_string)
    links_result = result['data']['allLinks']

    assert_equal links_result.first['votes'], []
  end
end
