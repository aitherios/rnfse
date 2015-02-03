# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Helper do

  class FakeBuilderClass
    include Rnfse::XMLBuilder::Helper
  end

  let(:builder) { FakeBuilderClass.new }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'base') }
  let(:xml) { Nokogiri::XML(File.read(File.join(xml_path, filename))) }

end
