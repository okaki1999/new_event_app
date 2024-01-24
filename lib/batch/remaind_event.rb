class Batch::RemaindEvent
    def self.remaind_event
      # Event.reload
      events_to_notify = Event.where("start_time <= ?", 24.hours.from_now)
  
      events_to_notify.each do |event|
        message = "#{event.user.username}さんのイベント「#{event.title}」は明日です！"
        LineService.broadcast(message)
      end
    end
  end