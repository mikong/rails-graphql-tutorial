# frozen_string_literal: true

require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::LinksSearch
  include SearchObject.module(:graphql)

  scope { Link.all }

  type types[Types::LinkType]

  class LinkFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :desc_contains, String, required: false
    argument :url_contains, String, required: false
  end

  option :filter, type: LinkFilter, with: :apply_filter

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    branches << get_scope_from(value)

    if value[:OR].present?
      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) }
    end

    branches
  end

  def get_scope_from(value)
    scope = Link.all
    if value[:desc_contains]
      scope = scope.where('description LIKE ?', "%#{value[:desc_contains]}%")
    end
    if value[:url_contains]
      scope = scope.where('url LIKE ?', "%#{value[:url_contains]}%")
    end
    scope
  end
end
