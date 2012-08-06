module CloudFormatter
  class ResourceDescriptor
    def initialize(template, type, &block)
      @template = template
      @type     = type
      @factory  = block
    end
    
    def create(params)
      instance = Instance.new(@template)
      (class << instance ; self ; end).__send__(:define_method, :hydrate, &@factory)
      instance.hydrate(*params)
      instance
    end
  end
end

