# -*- coding: utf-8 -*-
module Rnfse
  class Error
    # Metodos não implementados
    class NotImplemented < ::NotImplementedError; end

    # Ações de API que tem comportamento anômalo.
    # Em alguns provedores algumas ações, embora implemenadas não
    # funcionam ou tem comportamento anômalo.
    class BetterNotBeUsed < ::StandardError; end

    # Caracteres fora do padrão ASCII foram utilizados.
    class NonASCIIEncoding < ::StandardError; end
  end
end
