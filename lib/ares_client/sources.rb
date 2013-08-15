module AresClient

  # model obsahuje ciselnik zdroju
  class Sources
    SOURCES = {
      2 => "OR",
      4 => "RZP"
    }
    attr_accessor :id, :name

    def initialize(options)
      self.id   = options[:id]
      self.name = options[:name]
    end

    def self.find(id)
      all.detect{|source| source.id == id}
    end

    def self.find_by_name(name)
      all.detect{|source| source.name == name}
    end

    def self.all
      @@all ||= SOURCES.collect{ |source_id, source_name|
        new(:id=>source_id, :name=>source_name)
      }
    end
  end

end
