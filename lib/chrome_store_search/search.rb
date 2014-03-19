require 'rubygems'
require 'cgi'
require 'faraday'
require File.expand_path(File.dirname(__FILE__) + '/app_parser')

module ChromeStoreSearch
  class Search

    CHROME_STORE_URL = "https://chrome.google.com/webstore/"

    CHROME_STORE_SEARCH_URL = CHROME_STORE_URL + "ajax/item?"

    DEFAULT_SEARCH_CONDITION = {:hl =>"en-US",
      :count => 20,
      :category => nil}

    def initialize(search_condition = DEFAULT_SEARCH_CONDITION)
      @search_condition = DEFAULT_SEARCH_CONDITION.merge(search_condition)
    end

    def search(keyword)
      @keyword = keyword
      conn = Faraday.new(:url => init_query_url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      res = conn.post '', {}
      AppParser.parse(res.body)
    end

    private

    def init_query_url
      query_url = ""
      query_url << CHROME_STORE_SEARCH_URL
      query_url << "hl=#{@search_condition[:hl]}"
      query_url << "&count=#{@search_condition[:count]}"
      query_url << "&pv=#{get_pv}"
      query_url << "&container=CHROME&sortBy=0"
      query_url << "&category=#{@search_condition[:category]}" if @search_condition[:category]
      query_url << "&searchTerm=#{CGI.escape(@keyword)}"
    end

    def get_pv
      conn = Faraday.new(:url => CHROME_STORE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      res = conn.get ''
      res.body.match(/\/webstore\/static\/(\d+)\/wall/)[1]
    end

  end
end