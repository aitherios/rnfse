# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rnfse/version'

Gem::Specification.new do |s|
  s.name          = 'rnfse'
  s.version       = Rnfse::VERSION
  s.summary       = %q{Biblioteca para a API de Nota Fiscal de Serviços 
    eletrônica (NFS-e) da ABRASF.}
  s.description   = %q{Biblioteca para integração com as várias implementações
    municipais de Nota Fiscal de Serviços eletrônica (NFS-e) que utilizam uma 
    das versões ou variações dos padrões
    [ABRASF](http://www.abrasf.org.br/paginas_multiplas_detalhes.php?cod_pagina=1).}

  s.required_ruby_version = '>= 1.9.3'

  s.licenses      = ['MIT', 'GPL-3']

  s.authors       = ['Renan Mendes Carvalho']
  s.email         = ['aitherios@gmail.com']
  s.homepage      = 'https://github.com/aitherios/rnfse'

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'

  s.add_dependency 'json',                       '~> 1.0'
  s.add_dependency 'json-schema',                '~> 2.0'
  s.add_dependency 'gyoku',                      '~> 1.0'
  s.add_dependency 'nokogiri-xmlsec1',           '~> 0.0.7'

  s.add_development_dependency 'bundler',        '~> 1.3'
  s.add_development_dependency 'rake',           '~> 10.0'
  s.add_development_dependency 'rdoc',           '~> 4.0'
  s.add_development_dependency 'gem-release',    '~> 0.7.0'
  s.add_development_dependency 'rspec',          '~> 3.0.0'
  s.add_development_dependency 'rspec-its',      '~> 1.0.0'
  s.add_development_dependency 'simplecov',      '~> 0.7.0'
  s.add_development_dependency 'wwtd',           '~> 0.5.0'
  s.add_development_dependency 'equivalent-xml', '~> 0.4.0'
  s.add_development_dependency 'guard',          '~> 2.6.0'
  s.add_development_dependency 'guard-rspec',    '~> 4.2.0'
  s.add_development_dependency 'guard-bundler',  '~> 2.0.0'
  s.add_development_dependency 'foreman',        '~> 0.74.0'
  s.add_development_dependency 'pry',            '~> 0.10'
  if RUBY_VERSION.to_i < 2
    s.add_development_dependency 'pry-debugger', '~> 0.2'
  else
    s.add_development_dependency 'pry-byebug',   '~> 1.0'
  end

end
