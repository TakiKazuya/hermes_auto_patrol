require 'line/bot'
require 'dotenv'
Dotenv.load

module Notification
  class << self
    def push_line_message(text)
      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }

      client.push_message(ENV["LINE_CHANNEL_USER_ID"], {
        type: 'text',
        text: text
      })
    end
  end
end
