module CloudFormatter
  class Reference
    def initialize(name)
      @name = name
    end
    
    def to_json_data
      {REF => @name}
    end
    
    class Map
      def initialize(name)
        @name = name
      end
      
      def [](key)
        Key.new(@name, key)
      end
    end
    
    class Key
      def initialize(name, key)
        @map_name = name
        @key      = key
      end
      
      def to_json_data
        {FIND_IN_MAP => [DSL.format(@map_name), DSL.jsonize(@key)]}
      end
    end
    
  end
end

