# -*- coding: utf-8 -*-
require 'json-schema'

module Rnfse::API::Abrasf202

  module ClassMethods

    def operations
      [
        :recepcionar_lote_rps, :recepcionar_lote_rps_sincrono, :gerar_nfse,
        :cancelar_nfse, :substituir_nfse, :consultar_lote_rps, 
        :consultar_nfse_por_rps, :consultar_nfse_servico_prestado,
        :consultar_nfse_servico_tomado, :consultar_nfse_faixa
      ].sort
    end

    private

  end

  extend ClassMethods

  def self.extended(base)
    base.extend(ClassMethods)
  end

  def self.included(base)
    base.send(:include, ClassMethods)
  end

end
