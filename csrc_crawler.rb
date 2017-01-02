require_relative 'http_helper'
require 'nokogiri'
require 'date'

class CSRC_Crawler
  CSRC_HOST = "http://www.csrc.gov.cn"


  def initialize
    @helper = HTTPHelper.new(CSRC_HOST)
    @sites = [
      {:name => "beijing", :short => "bj"},
      {:name => "tianjin", :short => "tj"},
      {:name => "hebei", :short => "hb"},
      {:name => "shanxi", :short => "sx"},
      {:name => "neimenggu", :short => "nmg"},
      {:name => "liaoning", :short => "ln"},
      {:name => "jilin", :short => "jl"},
      {:name => "heilongjiang", :short => "hlj"},
      {:name => "shanghai", :short => "sh"},
      {:name => "jiangsu", :short => "js"},
      {:name => "zhejiang", :short => "zj"},
      {:name => "anhui", :short => "ah"},
      {:name => "fujian", :short => "fj"},
      {:name => "jiangxi", :short => "jx"},
      {:name => "shandong", :short => "sd"},
      {:name => "henan", :short => "hn"},
      {:name => "hubei", :short => "hub"},
      {:name => "hunan", :short => "hun"},
      {:name => "guangdong", :short => "gd"},
      {:name => "guangxi", :short => "gx"},
      {:name => "hainan", :short => "hain"},
      {:name => "chongqing", :short => "cq"},
      {:name => "sichuan", :short => "sc"},
      {:name => "guizhou", :short => "gz"},
      {:name => "yunnan", :short => "yn"},
      {:name => "xizang", :short => "xz"},
      {:name => "shanxi", :short => "sx"},
      {:name => "gansu", :short => "gs"},
      {:name => "qinghai", :short => "qh"},
      {:name => "ningxia", :short => "nx"},
      {:name => "xinjiang", :short => "xj"},
      {:name => "shenzhen", :short => "sz"},
      {:name => "dalian", :short => "dl"},
      {:name => "ningbo", :short => "nb"},
      {:name => "xiamen", :short => "xm"},
      {:name => "qingdao", :short => "qd"}
    ]
  end

  def run
    today = Time.now.to_date
    @sites.each
      path = "/pub/#{site[:name]}/#{site[:short]}fdqyxx/"
      resp = @helper.get(path)
      doc = Nokogiri.HTML(resp.body)
      doc.xpath('//div[@class="fl_list"]/ul/li').each { |row|

        title = row.xpath('a/@title').to_s
        dateStr = row.xpath('span/text()')[0].to_s
        date = Date.parse(dateStr)
        if date < today - 2
          next
        end
        puts title
        puts date

      }
    }

  end
end

if __FILE__ == $0
  crawler = CSRC_Crawler.new
  crawler.run
end