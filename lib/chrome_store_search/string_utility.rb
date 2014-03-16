module StringUtility
  def gsub_continuation_commas(json_str)
    json_str.gsub(/,,,*/) do |commas_str|
      replace_str = ""
      (commas_str.size-1).times do |index|
        replace_str += ",\"\""
      end
      commas_str = replace_str + ","
    end
  end

  def StringUtility.included cls
    cls.extend StringUtility
  end
end
