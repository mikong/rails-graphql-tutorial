# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = RailsGraphqlTutorialSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name,
    )
    render json: result
  rescue => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      string_to_hash(ambiguous_param)
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def string_to_hash(string)
    return {} if string.blank?

    ensure_hash(JSON.parse(string))
  end

  def handle_error_in_development(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render json: error_to_hash(err), status: 500
  end

  def error_to_hash(err)
    {
      error: {
        message: err.message,
        backtrace: err.backtrace
      },
      data: {}
    }
  end
end
