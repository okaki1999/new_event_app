namespace :push_task do
    desc "LINEBOT：タスクの通知" 
    task :push_line_message_task => :environment do
        client = Line::Bot::Client.new { |config|
            config.channel_secret = "2e2f5ffe42ae74cae510b05dfbb977b5"
            config.channel_token = "Ej6PStj9gKym35kX08JyMSaCGhxkWYLoWnkBqM+G2d3PncaHYAgSE5QSxwdvRgegFYLadvUB5UGmDd7O7zk4nBL6DUJSmM7Hyjy5lyO+crj1EvzITwb8mGiRVfFUIm62Lg/+1Sf2WEyh8eWjNAptDwdB04t89/1O/w1cDnyilFU="
        }

        limit_tasks = Event.where(endday: Date.today)
        limit_tasks.each do |t|
            message = {
                type: 'text',
                text: "「」の期限は今日でっせ！"
            }
            response = client.push_message(t.user_uid, message)
            p response
        end
    end
end
