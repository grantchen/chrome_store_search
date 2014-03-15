require 'json'
require File.expand_path(File.dirname(__FILE__) + '/app')

module ChromeStoreSearch
  class AppParser
    def self.parse(apps_json_body)
      apps_json_array = JSON.parse(gsub_continuation_commas(apps_json_body[4..-1]))[1][1]
      apps = []
      apps_json_array.each do |app_item|
        apps << new_app_instance(app_item)
      end
      return apps
    end

    private

    def self.gsub_continuation_commas(json_str)
      json_str.gsub(/,,,*/) do |commas_str|
        replace_str = ""
        (commas_str.size-1).times do |index|
          replace_str += ",\"\""
        end
        commas_str = replace_str + ","
      end
    end

    def self.new_app_instance(app_item)
      app = App.new
      app.id = app_item[0]
      app.name = app_item[1]
      app.small_logo_url = app_item[3].encode("UTF-8")
      app.description = app_item[6]
      app.rating = app_item[12]
      app.total_rating_count = app_item[22].to_i
      app.total_users = app_item[23].gsub(",", "").to_i
      app.big_logo_url = app_item[25].encode("UTF-8")
      app.url = app_item[37]
      return app
    end
  end
end