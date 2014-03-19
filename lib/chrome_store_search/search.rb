require 'rubygems'
require 'cgi'
require 'faraday'
require File.expand_path(File.dirname(__FILE__) + '/app_parser')
require File.expand_path(File.dirname(__FILE__) + '/string_utility')

module ChromeStoreSearch
  class Search

    CHROME_STORE_SEARCH_URL = "https://chrome.google.com/webstore/ajax/item?"

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
      query_url << "&pv=#{StringUtility.get_pv}"
      query_url << "&container=CHROME&sortBy=0"
      query_url << "&category=#{@search_condition[:category]}" if @search_condition[:category]
      query_url << "&searchTerm=#{CGI.escape(@keyword)}"
    end
  end
end
