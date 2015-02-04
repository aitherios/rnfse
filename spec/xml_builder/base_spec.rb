# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Base do

  class FakeBuilderClass
    include Rnfse::XMLBuilder::Base
  end

  let(:builder) { FakeBuilderClass.new }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'base') }
  let(:xml) { Nokogiri::XML(File.read(File.join(xml_path, filename))) }

  describe '#build_xml' do
    subject { builder.send(:build_xml, *options) }

    context 'when xmlns and action option are provided' do
      let!(:filename) { 'build_xml_action_xmlns.xml' }
      let!(:options) {[ 
                       { tag: 'content' }, 
                       { action: 'action', 
                         namespace: { 'xmlns' => 'http://test' } }
                     ]}

      it { is_expected.to be_equivalent_to(xml) }
      it { is_expected.to be_kind_of(Nokogiri::XML::Document) }
    end

    context 'when no options are provided, infer from caller method' do
      before do
        allow(Rnfse::CallChain).to receive(:caller_method) { 'build_previous_method_xml' }
      end
      let!(:filename) { 'build_xml.xml' }
      let!(:options) {[ { tag: 'content' } ]}

      it { is_expected.to be_equivalent_to(xml) }
      it { is_expected.to be_kind_of(Nokogiri::XML::Document) }
    end

    context 'when a block to customize the inner xml is called' do
      subject do
        builder.send(:build_xml, *options) do |data|
          xml = ::Gyoku.xml(data, key_converter: :none)
          "<custom-xml-handling>#{xml}</custom-xml-handling>"
        end
      end
      before do
        allow(Rnfse::CallChain).to receive(:caller_method) { 'build_previous_method_xml' }
      end
      let!(:filename) { 'build_xml_customized.xml' }
      let!(:options) {[ { tag: 'content' } ]}

      it { is_expected.to be_equivalent_to(xml) }
      it { is_expected.to be_kind_of(Nokogiri::XML::Document) }
    end
  end
  
end
