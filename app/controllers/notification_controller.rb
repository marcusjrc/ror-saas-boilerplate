class NotificationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[redirect_to_notification]

  def mark_notifications_as_read
    current_user.notifications.where(has_read: false).update(has_read: true)
  end

  def redirect_to_notification
    @notification.has_read = true
    @notification.save
    redirect_to @notification.url, allow_other_host: true
  end

  private

  def set_notification
    @notification = Notification.find(params[:notification_id])
    head(:unauthorized) if @notification.user != current_user
  end
end
