require 'json'
require 'forwardable'

module CloudFormatter
  DESCRIPTION = 'Description'
  FIND_IN_MAP = 'Fn::FindInMap'
  KEY         = 'Key'
  MAPPINGS    = 'Mappings'
  PROPERTIES  = 'Properties'
  REF         = 'Ref'
  RESOURCES   = 'Resources'
  TAGS        = 'Tags'
  TYPE        = 'Type'
  VALUE       = 'Value'
  VERSION     = 'AWSTemplateFormatVersion'
  
  ROOT = File.expand_path('..', __FILE__)
  
  autoload :Creator,            ROOT + '/cloud_formatter/creator'
  autoload :DSL,                ROOT + '/cloud_formatter/dsl'
  autoload :Instance,           ROOT + '/cloud_formatter/instance'
  autoload :Mappings,           ROOT + '/cloud_formatter/mappings'
  autoload :Reference,          ROOT + '/cloud_formatter/reference'
  autoload :ResourceDescriptor, ROOT + '/cloud_formatter/resource_descriptor'
  
  class Spec
    extend DSL
  end
end

