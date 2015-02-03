# -*- coding: utf-8 -*-

module Rnfse::XMLBuilder::Sia201
  include Rnfse::XMLBuilder::Abrasf202

  def alter_data_before_builder(hash)
    hash.camelize_keys!
  end

  def alter_data_before_recepcionar_lote_rps(hash)
    hash.gsub_keys!('ExibilidadeIss', 'ExigibilidadeISS')
    hash.merge!(
      :attributes! => { 
        :LoteRps => { 
          :versao => '2.01', 
          :Id => "lote#{hash[:LoteRps][:NumeroLote]}" } } )
    hash[:LoteRps][:ListaRps].merge!(
      :attributes! => {
        :Rps => {
          :xmlns => 'http://www.abrasf.org.br/nfse.xsd' }})
    hash[:LoteRps][:ListaRps][:Rps].map! do |rps|
      numero = rps[:InfDeclaracaoPrestacaoServico][:Rps][:IdentificacaoRps][:Numero]
      serie = rps[:InfDeclaracaoPrestacaoServico][:Rps][:IdentificacaoRps][:Serie]
      id = "%018d" % "#{numero}#{serie}".to_i

      rps.merge(
        :attributes! => { 
          :InfDeclaracaoPrestacaoServico => { :Id => "rps#{id}"  } } )
    end

    hash
  end

end
