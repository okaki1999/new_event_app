class Event < ApplicationRecord
  belongs_to :user
  belongs_to :region
  belongs_to :prefecture
  has_one :privacies, class_name: 'Privacy', dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :interesteds, dependent: :destroy
  has_many :absences, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :thumbnail
  has_many :post_comments, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  #バリゼーション（空欄をはじく）
  with_options presence: true do 
    validates :title
    validates :body
    validates :thumbnail
  end

  def self.send_notifications_for_upcoming_events
    events_to_notify = Event.where("start_time <= ?", 24.hours.from_now)
  
    events_to_notify.each do |event|
      message = "#{event.user.username}さんのイベント「#{event.title}」は明日です！"
      LineService.broadcast(message)
    end
  end
end
