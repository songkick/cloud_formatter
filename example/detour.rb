require 'rubygems'
require File.expand_path('../../lib/cloud_formatter', __FILE__)

class Detour < CloudFormatter::Spec
  description       "Create a detour stack"
  template_version  "2010-09-09"
  
  mappings do
    ami_ids "eu-west-1" => { "AMI" => "ami-edc6fe99" }
  end
  
  resource_type :mongo_instance do |key_name, ami_id|
    type "AWS::EC2::Instance"
    
    properties do
      image_id            ami_id
      security_group_ids  ["sg-abcd1234", "sg-zxcv9876"]
      subnet_id           "subnet-xxxxxx"
      instance_type       "m1.medium"
      
      tags :name => key_name, :application => ref("AWS::StackName")
    end
  end
  
  create do
    mongo_instance "MongoInstanceAZa", "detour", ami_ids[ref("AWS::Region")]['AMI']
  end
end

puts Detour.to_json

