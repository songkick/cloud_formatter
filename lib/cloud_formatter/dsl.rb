module CloudFormatter
  module DSL
    def self.format(key)
      key.to_s.gsub(/(.)_(.)/) { $1 + $2.upcase }.gsub(/^(.)/) { $1.upcase }
    end
    
    def self.jsonize(value)
      case value
        when Array then value.map { |v| jsonize v }
        else
          value.respond_to?(:to_json_data) ? value.to_json_data : value
      end
    end
    
    def mappings(&block)
      _mappings.instance_eval(&block)
    end
    
    def resource_type(name, &block)
      _resource_descriptors[name.to_s] = ResourceDescriptor.new(self, name, &block)
    end
    
    def create(&block)
      Creator.new(self).instance_eval(&block)
    end
    
    def to_json
      JSON.pretty_generate(generate_spec)
    end
    
    def reference_type(name)
      if _mappings.has_key?(name)
        :map
      elsif _resource_descriptors.has_key?(name)
        :resource
      end
    end
    
    def add_instance(resource_type, name, *params)
      descriptor = _resource_descriptors[resource_type]
      _instances[name] = descriptor.create(params)
    end
    
    def method_missing(field, value)
      instance_variable_set("@#{field}", value)
    end
    
  private
    
    def generate_spec
      spec = {
        DESCRIPTION => @description,
        VERSION     => @template_version,
        MAPPINGS    => DSL.jsonize(_mappings),
        RESOURCES   => {}
      }
      _instances.each do |name, instance|
        spec[RESOURCES][name] = DSL.jsonize(instance)
      end
      spec
    end
    
    def _mappings
      @mappings ||= Mappings.new
    end
    
    def _resource_descriptors
      @resource_descriptors ||= {}
    end
    
    def _instances
      @instances ||= {}
    end
  end
end

