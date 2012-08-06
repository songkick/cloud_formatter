module CloudFormatter
  class Creator
    def initialize(template)
      @template = template
    end
    
    def ref(name)
      Reference.new(name)
    end
    
    def method_missing(name, *params)
      name = name.to_s
      case @template.reference_type(name)
      when :map
        Reference::Map.new(name)
      when :resource
        @template.add_instance(name, *params)
      end
    end
  end
end

