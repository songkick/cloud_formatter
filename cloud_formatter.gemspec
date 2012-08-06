Gem::Specification.new do |s|
  s.name              = "cloud_formatter"
  s.version           = "0.1.0"
  s.summary           = "Generate JSON config for AWS CloudFormation"
  s.author            = "James Coglan"
  s.email             = "james@songkick.com"

  s.extra_rdoc_files  = %w[README.rdoc]
  s.rdoc_options      = %w[--main README.rdoc]
  s.require_paths     = %w[lib]

  s.add_dependency "json"
end

