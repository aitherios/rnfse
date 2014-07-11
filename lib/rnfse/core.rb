module Rnfse
  def self.configuration
    Rnfse::Configuration.instance
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
