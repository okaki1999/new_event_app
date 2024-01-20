require 'line/bot'
class LineController < ApplicationController
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_SECRET_KEY']
      config.channel_token = ENV['LINE_TOKEN']
    end
  end

  def push(user:, message:)
    user_id =  ENV['LINE_USER_ID']
    client.push_message(user_id, message)
  end
end