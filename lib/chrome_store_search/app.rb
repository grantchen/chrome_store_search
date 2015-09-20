require 'faraday'
require 'json'
require File.expand_path(File.dirname(__FILE__) + '/string_utility')

module ChromeStoreSearch
  class App
    attr_accessor :id, :name, :url, :short_description, :small_logo_url,
                  :big_logo_url, :rating, :total_rating_count,
                  :total_users, :description, :site, :version,
                  :updated_at, :support_url, :videos, :images,
                  :size, :languages

    APP_DETAIL_BASE_URL = "https://chrome.google.com/webstore/ajax/detail?"

    DEFAULT_PARAMETER = {:hl =>"en-US"}

    def initialize(id=nil)
      update_detail_info(id) if id
    end

    def update_detail_info(id, parmeter = DEFAULT_PARAMETER)
      @parmeter = DEFAULT_PARAMETER.merge(parmeter)
      conn = Faraday.new(:url => init_detail_url(id)) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
      res = conn.post '', {}
      parse_detail(res.body)
    end

    def set_basic_info(app_item)
      self.id = app_item[0]
      self.name = app_item[1]
      self.small_logo_url = app_item[3].encode("UTF-8")
      self.short_description = app_item[6]
      self.rating = app_item[12]
      self.total_rating_count = app_item[22].to_i
      self.total_users = app_item[23].gsub(",", "").to_i
      self.big_logo_url = app_item[25].encode("UTF-8")
      self.url = app_item[37]
    end

    private

    def init_detail_url(id)
      detail_url = APP_DETAIL_BASE_URL
      detail_url << "hl=#{@parmeter[:hl]}"
      detail_url << "&pv=#{StringUtility.get_pv}"
      detail_url << "&id=#{id}"
      detail_url << "&container=CHROME"
    end

    def parse_detail(app_detail_body)
      detail_info = JSON.parse(StringUtility.gsub_continuation_commas(app_detail_body[4..-1]))[1][1]
      basic_info = detail_info[0]
      set_basic_info(basic_info)
      self.description = detail_info[1]
      self.site = detail_info[3]
      self.support_url = detail_info[5]
      self.version = detail_info[6]
      self.updated_at = detail_info[7]
      self.languages = detail_info[8]
      self.size = detail_info[-8]
      videos_images = detail_info[11]
      videos_images.each do |vi|
        if vi[18].include?("https://i.ytimg.com")
          self.videos = [] unless self.videos
          self.videos << vi[19]
        else
          self.images = [] unless self.images
          self.images << vi[17]
        end
      end
    end
  end
end
