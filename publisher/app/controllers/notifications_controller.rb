class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      render json: { notification: @notification }, status: :created
    else
      render json: { errors: @notification.errors }, status: :unprocessable_entity
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:email, :subject, :content)
  end
end