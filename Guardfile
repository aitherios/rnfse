guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$})  { 'spec' }
  watch('spec/spec_helper.rb')        { 'spec' }
  watch(%r{^lib/rnfse/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/rnfse/api/(.+)\.rb$}) { |m| "spec/api/#{m[1]}_spec.rb" }
  watch(%r{^lib/rnfse/api/(.+)/(.+)\.rb$}) { |m| "spec/api/#{m[1]}/#{m[2]}_spec.rb" }
  watch(%r{^lib/rnfse/api/(.+)/(.+)\.json$}) { |m| "spec/api/#{m[1]}/#{m[2]}_json_spec.rb" }
end

guard :bundler do
  watch(/^.+\.gemspec/)
  watch(/^Gemfile/)
end
