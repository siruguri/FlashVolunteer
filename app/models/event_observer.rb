class EventObserver < ActiveRecord::Observer

    def after_destroy(event)
        event.participants.each do |user|
            # send the e-mail
            if Rails.env.production?
                UserMailer.delay.event_deleted(event, user)
            else
                UserMailer.event_deleted(event, user).deliver
            end
        end
    end
end