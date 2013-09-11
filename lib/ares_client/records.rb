module AresClient

  # model pro praci se zakladnim vypisem ARES
  class Records

    attr_accessor :ic, :basic_output, :response, :http_response

    include HTTParty
    base_uri 'http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_bas.cgi'

    def initialize(ic=nil)
      @ic = ic if ic
    end

    def fetch
      self.http_response = self.class.get("?ico=#{ic}&jazyk=cz&aktivni=false&ver=1.0.2")
      self.response = http_response.parsed_response
    end

    def basic_output
      response['Ares_odpovedi']['Odpoved']['Vypis_basic']
    end

    def name
      basic_output['Obchodni_firma']['__content__']
    end

    def dic
      basic_output['DIC']['__content__'] if basic_output['DIC']
    end

    def address_code
      basic_output['Adresa_ARES']['Adresa_UIR']['Kod_adresy'] if basic_output['Adresa_ARES']['Adresa_UIR']
    end

    def building_code
      basic_output['Adresa_ARES']['Adresa_UIR']['Kod_objektu'] if basic_output['Adresa_ARES']['Adresa_UIR']
    end

    def established_on
      basic_output['Datum_vzniku']
    end

    def self.find_by_ic(ic)
      record = self.new(ic)
      record.fetch
      record
    end

    def self.from_xml(xml)
      request = new
      request.response = MultiXml.parse(xml)
      request.ic = request.basic_output['ICO']['__content__']
      request
    end

  end

end
