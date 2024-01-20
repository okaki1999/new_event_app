

class PushLineJob < ApplicationJob
  queue_as :default

  def perform(*args)
    limit_seven_days = Date.today..Time.now.end_of_day + (7.days)
    users = User.all
    users.each do |user|
      if user.line_alert == true
        limit_items =  ExpendableItem.where(user_id: user.id).where(deadline_on: limit_seven_days)
        if limit_items != []
          names = limit_items.map {|item| item.name } 
          message = {
                type: 'text',
                text: "1週間以内に#{names.join(',')}が無くなります。早めの買い足しをオススメします。"
              }
          response = line_client.push_message(user.uid, message)
          logger.info "PushLineSuccess"
        end
      end
    end
  end

  private

  def line_client
    Line::Bot::Client.new { |config|
      config.channel_secret = "2e2f5ffe42ae74cae510b05dfbb977b5"
      config.channel_token = "Ej6PStj9gKym35kX08JyMSaCGhxkWYLoWnkBqM+G2d3PncaHYAgSE5QSxwdvRgegFYLadvUB5UGmDd7O7zk4nBL6DUJSmM7Hyjy5lyO+crj1EvzITwb8mGiRVfFUIm62Lg/+1Sf2WEyh8eWjNAptDwdB04t89/1O/w1cDnyilFU="
    }
  end
end