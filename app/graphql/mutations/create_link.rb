# frozen_string_literal: true

module Mutations
  class CreateLink < BaseMutation
    argument :url, String, required: true
    argument :description, String, required: false

    type Types::LinkType

    def resolve(url: nil, description: nil)
      Link.create!(
        url: url,
        description: description,
        user: context[:current_user],
      )
    end
  end
end
