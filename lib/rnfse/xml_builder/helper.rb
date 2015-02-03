# -*- coding: utf-8 -*-

# Helpers para transformar o hash a ser convertido em xml.
module Rnfse::XMLBuilder::Helper

  # converte as chaves do hash para CamelCase
  def camelize_hash(hash)
    Rnfse::Hash.camelize_and_symbolize_keys(hash)
  end

end
