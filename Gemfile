# encoding: utf-8

source 'https://rubygems.org'

gemspec

GITHUB = 'https://github.com'

def github(name)
  { git: "#{GITHUB}/#{name}.git" }
end

gem 'axiom-schema', path: '.'

gem 'axiom',           github('dkubb/axiom')
gem 'axiom-optimizer', github('dkubb/axiom-optimizer')
gem 'anima',           github('mbj/anima')

group :test do
  gem 'axiom-memory-adapter', github('dkubb/axiom-memory-adapter')
end

group :development do
  gem 'devtools', github('rom-rb/devtools')
end

# added by devtools
eval_gemfile 'Gemfile.devtools'
