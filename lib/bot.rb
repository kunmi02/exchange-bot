require 'telegram/bot'
require_relative 'motive.rb'
require_relative 'exchange.rb'

class Bot
  def initialize
    token = '1488384719:AAHNKM9crgr3yZznIgBqzE18_fD1lhOug-8'

  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      # p '!!!!!!!!!!!'
      splitted_string = message.text.split
      p '!!!!!SPLITTED  STRING RE OO!!!!!'
      p splitted_string

      case splitted_string[0]
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} , welcome to motivation and exchange rate conversion chat bot created by Azeez, the chat bot is to keep you motivated and helps you convert currencies from one rate to another. Use  /start to start the bot,  /stop to end the bot, /motivate to get a diffrent motivational quote everytime you request for it, /exchange to convert from one currency to another. E.g /exchange 1USD to 1AUD")

      when '/stop'

        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
      when '/motivate'
        values = Motivate.new
        value = values.select_random
        bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date)
      when '/rate'
        if splitted_string.length <= 1
          bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name} I do not understand what you mean \n but if you intend to know a currency rate \n format should be like this E.g /rate USD", date: message.date)
        else
          rate = Exchangerate.new(base_currency=splitted_string[1])
          rates = rate.get_latest_currency_conversion_rate
          all_rates = ''
            rates.each do |key, value|
              all_rates += " #{key} = #{value} \n"
            end
          bot.api.send_message(chat_id: message.chat.id, text: "#{all_rates}", date: message.date)
        end
      when '/countries'
        exchange = Exchangerate.new
        supported_countries = exchange.supported_countries
        bot.api.send_message(chat_id: message.chat.id, text: "#{supported_countries}")

      when '/exchange'
        if splitted_string.length < 3
          bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name} I do not understand what you mean \n but if you intend to convert from one currency to another \n format should be like this E.g /exchange 1USD to 1AUD", date: message.date)
        else
          base = splitted_string[1].scan(/\d+|\D+/)
          current = splitted_string[3].scan(/\d+|\D+/)
          p '*********'
          p base
          p current
          p '**********'
        bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name} Welcome to Exchange bot", date: message.date)
        end
      else bot.api.send_message(chat_id: message.chat.id, text: "Invalid entry, #{message.from.first_name}, you need to use  /start,  /stop , /motivate, /exchange 1USD to 1AUD")
      end
    end
  end
  end
end