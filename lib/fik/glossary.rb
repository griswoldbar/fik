module Fik
  class Glossary
    attr_reader :config
    def initialize(config)
      @config = config
    end
    
    def lookup(name)
      found = nil
      thing_type = nil
      ["objects", "rooms"].each do |type|
        if @config[type][name].present?
          found = @config[type][name]
          thing_type = type[0..-2]
        end
      end
      raise "no such object: #{name}" unless found
      found.merge("type" => thing_type)
    end
  end
end