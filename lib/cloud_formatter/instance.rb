module CloudFormatter
  class Instance
    def initialize(template)
      @template   = template
      @type       = nil
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
      tag_map = Hash[tag_map.map { |key, value| [key.to_s, value] }]
      tag_map.keys.sort.each do |key|
        list << {KEY => DSL.format(key), VALUE => DSL.jsonize(tag_map[key])}
      end
    end
    
    def ref(name)
      Reference.new(name)
    end
    
    def to_json_data
      {TYPE => @type, PROPERTIES => @properties}
    end
    
    def method_missing(field, *params)
      if @template.reference_type(field.to_s) == :map
        Reference::Map.new(field)
      else
        @current_map[DSL.format(field)] = DSL.jsonize(params.first)
      end
    end
  end
end

