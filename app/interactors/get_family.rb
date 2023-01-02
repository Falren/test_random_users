# frozen_string_literal: true

class GetFamily
  include Interactor

  def call
    return context.user = user if user

    context.fail!(error: 'No person found')
  end

  private

  def user
    @user ||= User.find_by(id: context.id)
  end
end
