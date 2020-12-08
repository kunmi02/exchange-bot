# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'
require_relative 'requester'

class Exchangerate
  include Requester

  def initialize(base_currency = nil, target_currency = nil, amount = nil)
    @token = '73e652270cb72a930df06bf1'
    @base_currency = base_currency unless base_currency.nil?
    @target_currency = target_currency unless target_currency.nil?
    @amount = amount unless amount.nil?
  end

  # not available on free versions
  def get_currency_conversion_rate
    Requester.call_api("https://v6.exchangerate-api.com/v6/#{@token}/pair/EUR/GBP/#{@amount}")
  end

  def get_latest_currency_conversion_rate
    response = Requester.call_api("https://v6.exchangerate-api.com/v6/#{@token}/latest/#{@base_currency}")
    response['conversion_rates']
  end

  def calculate_conversion(base_amount, target_amount)
    base_amount.to_f * target_amount.to_f
  end

  def supported_countries
    "Currency Code	Currency Name	Country
    AED	UAE Dirham	United Arab Emirates
    ARS	Argentine Peso	Argentina
    AUD	Australian Dollar	Australia
    BGN	Bulgarian Lev	Bulgaria
    BRL	Brazilian Real	Brazil
    BSD	Bahamian Dollar	Bahamas
    CAD	Canadian Dollar	Canada
    CHF	Swiss Franc	Switzerland
    CLP	Chilean Peso	Chile
    CNY	Chinese Renminbi	China
    COP	Colombian Peso	Colombia
    CZK	Czech Koruna	Czech Republic
    DKK	Danish Krone	Denmark
    DOP	Dominican Peso	Dominican Republic
    EGP	Egyptian Pound	Egypt
    EUR	Euro	Germany
    EUR	Euro	Austria
    EUR	Euro	Belgium
    EUR	Euro	Cyprus
    EUR	Euro	Estonia
    EUR	Euro	Finland
    EUR	Euro	France
    EUR	Euro	Greece
    EUR	Euro	Ireland
    EUR	Euro	Italy
    EUR	Euro	Latvia
    EUR	Euro	Lithuania
    EUR	Euro	Luxembourg
    EUR	Euro	Malta
    EUR	Euro	Netherlands
    EUR	Euro	Portugal
    EUR	Euro	Slovakia
    EUR	Euro	Slovenia
    EUR	Euro	Spain
    FJD	Fiji Dollar	Fiji
    GBP	Pound Sterling	United Kingdom
    GTQ	Guatemalan Quetzal	Guatemala
    HKD	Hong Kong Dollar	Hong Kong
    HRK	Croatian Kuna	Croatia
    HUF	Hungarian Forint	Hungary
    IDR	Indonesian Rupiah	Indonesia
    ILS	Israeli New Shekel	Israel
    INR	Indian Rupee	India
    ISK	Icelandic Krona	Iceland
    JPY	Japanese Yen	Japan
    KRW	South Korean Won	South Korea
    KZT	Kazakhstani Tenge	Kazakhstan
    MVR	Maldivian Rufiyaa	Maldives
    MXN	Mexican Peso	Mexico
    MYR	Malaysian Ringgit	Malaysia
    NOK	Norwegian Krone	Norway
    NZD	New Zealand Dollar	New Zealand
    PAB	Panamanian Balboa	Panama
    PEN	Peruvian Sol	Peru
    PHP	Philippine Peso	Philippines
    PKR	Pakistani Rupee	Pakistan
    PLN	Polish Zloty	Poland
    PYG	Paraguayan Guarani	Paraguay
    RON	Romanian Leu	Romania
    RUB	Russian Ruble	Russia
    SAR	Saudi Riyal	Saudi Arabia
    SEK	Swedish Krona	Sweden
    SGD	Singapore Dollar	Singapore
    THB	Thai Baht	Thailand
    TRY	Turkish Lira	Turkey
    TWD	New Taiwan Dollar	Taiwan
    UAH	Ukrainian Hryvnia	Ukraine
    USD	United States Dollar	United States
    UYU	Uruguayan Peso	Uruguay
    ZAR	South African Rand	South African "
  end
end
