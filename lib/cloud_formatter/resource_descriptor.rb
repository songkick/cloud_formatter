module CloudFormatter
  class ResourceDescriptor
    def initialize(type, &block)
      @type    = type
      @factory = block
    end
    
    def create(params)
      instance = Instance.new
      (class << instance ; self ; end).__send__(:define_method, :hydrate, &@factory)
      instance.hydrate(*params)
      instance
    end
  end
end

