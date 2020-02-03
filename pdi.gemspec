# frozen_string_literal: true

require './lib/pdi/version'

Gem::Specification.new do |s|
  s.name        = 'pdi'
  s.version     = PDI::VERSION
  s.summary     = 'Ruby wrapper for invoking Pentaho Data Integration'

  s.description = <<-DESCRIPTION
    Pentaho Data Integration allows for the creation of ETL transformation and jobs.  This library allows those ETL tasks to be executed from Ruby.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio']
  s.email       = ['mruggio@bluemarblepayroll.com']
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.homepage    = 'https://github.com/bluemarblepayroll/pdi'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.3.8'

  s.add_dependency('acts_as_hashable', '~>1')

  s.add_development_dependency('guard-rspec', '~>4.7')
  s.add_development_dependency('pry', '~>0')
  s.add_development_dependency('rake', '~> 13')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop', '~>0.79.0')
  s.add_development_dependency('simplecov', '~>0.17.0')
  s.add_development_dependency('simplecov-console', '~>0.6.0')
end
