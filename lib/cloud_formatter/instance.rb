module CloudFormatter
  class Instance
    def initialize
      @type = nil
      @properties = {}
    end
    
    def type(value)
      @type = value
    end
    
    def properties
      old_map = @current_map
      @current_map = @properties
      yield
      @current_map = old_map
    end
    
    def tags(tag_map)
      list = @current_map[TAGS] ||= []
      tag_map.each do |key, value|
        list << {KEY => DSL.format(key), VALUE => DSL.jsonize(value)}
      end
    end
    
    def ref(name)
      Reference.new(name)
    end
    
    def to_json_data
      {TYPE => @type, PROPERTIES => @properties}
    end
    
    def method_missing(field, value)
      @current_map[DSL.format(field)] = DSL.jsonize(value)
    end
  end
end

