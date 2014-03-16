require 'json'
require File.expand_path(File.dirname(__FILE__) + '/app')
require File.expand_path(File.dirname(__FILE__) + '/string_utility')

module ChromeStoreSearch
  class AppParser
    include StringUtility

    def self.parse(apps_json_body)
      apps_json_array = JSON.parse(gsub_continuation_commas(apps_json_body[4..-1]))[1][1]
      apps = []
      apps_json_array.each do |app_item|
        apps << new_app_instance(app_item)
      end
      return apps
    end

    private

    def self.new_app_instance(app_item)
      app = App.new
      app.set_basic_info(app_item)
      return app
    end
  end
end