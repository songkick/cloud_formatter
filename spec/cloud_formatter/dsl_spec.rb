require "spec_helper"

class Detour < CloudFormatter::Spec
  description       "Create a detour stack"
  template_version  "2010-09-09"
  
  mappings do
    ami_ids "eu-west-1" => "ami-edc6fe99"
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
    mongo_instance "MongoInstanceAZa", "detour", ami_ids[ref("AWS::Region")]
  end
end

describe CloudFormatter::DSL do
  it "generates JSON" do
    JSON.parse(Detour.to_json).should == {
      "Description"               => "Create a detour stack",
      "AWSTemplateFormatVersion"  => "2010-09-09",
      
      "Mappings" => {
        "AmiIds" => {
          "eu-west-1" => "ami-edc6fe99"
        }
      },
      
      "Resources" => {
        "MongoInstanceAZa" => {
          "Type" => "AWS::EC2::Instance",
          "Properties" => {
            "ImageId"           => {"Fn::FindInMap" => ["AmiIds", {"Ref" => "AWS::Region"}]},
            "SecurityGroupIds"  => ["sg-abcd1234", "sg-zxcv9876"],
            "SubnetId"          => "subnet-xxxxxx",
            "InstanceType"      => "m1.medium",
            "Tags" => [
              {"Key" => "Name", "Value" => "detour"}, {"Key" => "Application", "Value" => {"Ref" => "AWS::StackName"}}
            ]
          }
        }
      }
    }
  end
end

