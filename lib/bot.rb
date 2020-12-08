# rubocop:disable Metrics/CyclomaticComplexity, Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength, Layout/LineLength
require 'telegram/bot'
require_relative 'motive'
require_relative 'exchange'

class Bot
  def initialize
    token = '1488384719:AAHNKM9crgr3yZznIgBqzE18_fD1lhOug-8'

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        splitted_string = message.text.split

        case splitted_string[0]
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} , welcome to motivation and exchange rate conversion chat bot created by Azeez, the chat bot is to keep you motivated and helps you convert currencies from one rate to another. Use  /start to start the bot,  /stop to end the bot, /motivate to get a diffrent motivational quote everytime you request for it, /exchange to convert from one currency to another. E.g /exchange 1USD to 1AUD")

        when '/stop'

          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
        when '/motivate'
          values = Motivate.new
          value = values.select_random
          bot.api.send_message(chat_id: message.chat.id, text: (value['text']).to_s, date: message.date)
        when '/rate'
          if splitted_string.length <= 1
            bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name} I do not understand what you mean \n but if you intend to know a currency rate \n format should be like this E.g /rate USD", date: message.date)
          else
            rate = Exchangerate.new(splitted_string[1])
            rates = rate.get_latest_currency_conversion_rate
            all_rates = ''
            rates.each do |key, val|
              all_rates += " #{key} = #{val} \n"
            end
            bot.api.send_message(chat_id: message.chat.id, text: all_rates.to_s, date: message.date)
          end
        when '/countries'
          exchange = Exchangerate.new
          supported_countries = exchange.supported_countries
          bot.api.send_message(chat_id: message.chat.id, text: supported_countries.to_s)

        when '/exchange'
          if splitted_string.length < 3
            bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name} I do not understand what you mean \n but if you intend to convert from one currency to another \n format should be like this E.g /exchange 1USD to 1AUD", date: message.date)
          else
            base = splitted_string[1].scan(/\d+|\D+/)
            current = splitted_string[3].scan(/\d+|\D+/)
            rate = Exchangerate.new(base_currency = base[1])
            rates = rate.get_latest_currency_conversion_rate
            rates[current[1]]
            conversion = rate.calculate_conversion(base[0], rates[current[1]])
            bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name} The conversion is #{conversion}#{current[1]}", date: message.date)
          end
        else bot.api.send_message(chat_id: message.chat.id, text: "Invalid entry, #{message.from.first_name}, you need to use  /start,  /stop , /motivate, /exchange 1USD to 1AUD")
        end
      end
    end
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength, Layout/LineLength
