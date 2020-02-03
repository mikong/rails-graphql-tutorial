# frozen_string_literal: true

require 'test_helper'

module Resolvers
  class LinksSearchTest < ActiveSupport::TestCase
    def find(args)
      ::Resolvers::LinksSearch.call(nil, args, nil)
    end

    def create_link(**attributes)
      create :link, attributes.merge(user: create(:user))
    end

    test 'filter option' do
      link1 = create_link description: 'test1', url: 'http://test1.com'
      link2 = create_link description: 'test2', url: 'http://test2.com'
      link3 = create_link description: 'test3', url: 'http://test3.com'
      _link4 = create_link description: 'test4', url: 'http://test4.com'

      filter = {
        filter: {
          desc_contains: 'test1',
          OR: [{
            url_contains: 'test2',
            OR: [{
              url_contains: 'test3'
            }]
          }, {
            desc_contains: 'test2'
          }]
        }
      }
      result = find(filter)

      assert_equal result.map(&:url).sort, [link1, link2, link3].map(&:url).sort
    end
  end
end
