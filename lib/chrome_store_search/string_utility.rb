require 'faraday'
require 'json'

module ChromeStoreSearch
  class StringUtility

    CHROME_STORE_URL = "https://chrome.google.com/webstore/"

    def self.gsub_continuation_commas(json_str)
      json_str.gsub(/,,,*/) do |commas_str|
        replace_str = ""
        (commas_str.size-1).times do |index|
          replace_str += ",\"\""
        end
        commas_str = replace_str + ","
      end
    end


    def self.get_pv
      conn = Faraday.new(:url => CHROME_STORE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      res = conn.get ''
      session_str = gsub_continuation_commas(res.body.match(/<script type="application\/json" id="cws-session-data">([\s\S]*?)<\/script>/i)[1])
      JSON.parse(session_str)[-6]
    end
  end
end
