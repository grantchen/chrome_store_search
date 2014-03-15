require 'rubygems'
require 'net/https'
require 'uri'
require 'cgi'
require File.expand_path(File.dirname(__FILE__) + '/app_parser')

module ChromeStoreSearch
  class Search

    CHROME_STORE_BASE_URL = "https://chrome.google.com/webstore/ajax/item?"

    DEFAULT_SEARCH_CONDITION = {:hl =>"en-US",
      :count => 20,
      :pv => 1394218756,
      :category => nil}

    def initialize(search_condition = DEFAULT_SEARCH_CONDITION)
      @search_condition = DEFAULT_SEARCH_CONDITION.merge(search_condition)
    end

    def search(keyword)
      @keyword = keyword
      uri = URI.parse(init_query_url)
      res = Net::HTTP.post_form(uri,{})
      AppParser.parse(res.body)
    end

    private

    def init_query_url
      query_url = ""
      query_url << CHROME_STORE_BASE_URL
      query_url << "hl=#{@search_condition[:hl]}"
      query_url << "&count=#{@search_condition[:count]}"
      query_url << "&pv=#{@search_condition[:pv]}"
      query_url << "&container=CHROME&sortBy=0"
      query_url << "&category=#{@search_condition[:category]}" if @search_condition[:category]
      query_url << "&searchTerm=#{CGI.escape(@keyword)}"
    end

  end
end