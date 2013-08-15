module AresClient

  # model pro praci s vypisem zmen v ARES
  class Changes

    attr_accessor :source, :response, :data, :parsed_response, :http_response
    attr_accessor :date, :batch_id, :all

    include HTTParty
    base_uri 'http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_zm.cgi'

    def initialize(source=nil)
      @source = source
    end

    ## BATCH RANGE

    def current_range
      @current_range ||= fetch_range
    end

    def fetch_range
      @http_response = self.class.get("?cislo_zdroje=#{source.id}")
      @data = http_response.parsed_response
      puts "Source #{source.name} : #{from}..#{to}"
      (from..to)
    end

    def from
      data['Ares_odpovedi']['Odpoved']['Zadani']['C_davky_od']
    end

    def to
      data['Ares_odpovedi']['Odpoved']['Zadani']['C_davky_do']
    end

    ## BATCH

    def fetch(batch_id)
      self.batch_id = batch_id
      self.response = self.class.get("?cislo_zdroje=#{source.id}&cislo_davky_od=#{batch_id}&cislo_davky_do=#{batch_id}")
      @parsed_response = response.parsed_response
    end

    def date
      parsed_response['Ares_odpovedi']['Odpoved']['Zadani']['D_davky_od']
    end

    def all
      @all ||= parsed_response['Ares_odpovedi']['Odpoved']['S']['ic'].inject({}){|total,y| total.merge({y['__content__']=>y['p']})}
    end

    def added
      all.select{|key,value| value=="N"}.collect{|ic,change| ic}
    end

    def updated
      all.select{|key,value| value=="U"}.collect{|ic,change| ic}
    end

    def deleted
      all.select{|key,value| value=="F"}.collect{|ic,change| ic}
    end

    def self.from_xml(xml)
      request = new
      request.parsed_response = MultiXml.parse(xml)
      request
    end

  end

end
