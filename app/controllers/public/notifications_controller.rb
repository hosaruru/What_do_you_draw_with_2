class Public::NotificationsController < ApplicationController
    def index
        @notifications = current_user.passive_notifications.page(params[:page]).per(20)
        # 未確認の通知レコードだけ取り出したあと、「未確認→確認済」になるように更新
        @notifications.where(checked: false).each do |notification|
            notification.update(checked: true)
        end
    end
end
