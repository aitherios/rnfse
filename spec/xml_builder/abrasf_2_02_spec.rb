# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder::Abrasf202 do

  let(:builder) { Rnfse::XMLBuilder.new(padrao: :abrasf_2_02) }
  let(:xml_path) { File.join($ROOT, 'spec', 'fixtures', 'abrasf_2_02') }
  let(:xml) { Nokogiri::XML(File.read(File.join(xml_path, filename))) }

  describe '#build_recepcionar_lote_rps_xml' do
    let!(:filename) { 'enviar_lote_rps_envio.xml' }
    subject do 
      builder.build_recepcionar_lote_rps_xml({
        lote_rps: {
          numero_lote: 2
        }
      }) 
    end

    it { is_expected.not_to be_equivalent_to(xml) }
    it { is_expected.to be_kind_of(Nokogiri::XML::Document) }
  end

  describe '#build_recepcionar_lote_rps_sincrono_xml'
  describe '#build_gerar_nfse_xml'
  describe '#build_cancelar_nfse_xml'
  describe '#build_substuir_nfse_xml'
  describe '#build_consultar_lote_rps_xml'
  describe '#build_consultar_nfse_por_rps_xml'
  describe '#build_consultar_nfse_servico_prestado_xml'
  describe '#build_consultar_nfse_servico_tomado_xml'
  describe '#build_consultar_nfse_faixa_xml'
  
end
