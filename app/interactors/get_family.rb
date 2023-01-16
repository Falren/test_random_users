# frozen_string_literal: true

class GetFamily < BaseInteractor
  def call
    return context.user = user if user

    context.fail!(error: 'No person was found')
  end

  private

  def user
    @user ||= User.find_by(id: context.id)
  end
end
