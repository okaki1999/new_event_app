class LineService
  def self.broadcast(message)
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_SECRET_KEY']
      config.channel_token = ENV['LINE_TOKEN']
    }

    message = {
      type: 'text',
      text: message
    }

    client.broadcast(message)
  end
end