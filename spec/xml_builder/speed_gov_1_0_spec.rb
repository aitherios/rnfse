# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::IssNet10 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :speed_gov_1_0) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'speed_gov_1_0') }

  describe '#build_consultar_nfse_envio_xml' do
    let(:xml) do 
      Nokogiri::XML(File.read(File.join(xml_path, 'consultar_nfse_parameters.xml')))
    end

    subject do
      builder.build_consultar_nfse_envio_xml({
        prestador: {
          cnpj: "07.792.435/0009-12",
          inscricao_municipal: "59274734"
        }
      })
    end

    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_header_xml' do
    let(:xml) do
      Nokogiri::XML(File.read(File.join(xml_path, 'header.xml')))
    end

    subject do
      builder.build_header_xml()
    end
    
    it { should be_equivalent_to(xml) }
    it { should be_kind_of(Nokogiri::XML::Document) }
  end

end
