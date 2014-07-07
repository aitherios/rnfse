# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::XMLBuilder do

  describe '::new' do
    context 'construindo um XMLBuilder para o padrão ABRASF 1.0,' do
      let(:builder) { Rnfse::XMLBuilder.new(padrao: :abrasf_1_0) }
      it { expect(builder).not_to be_nil }
      it { expect(builder).to respond_to(:build_recepcionar_lote_rps_xml) }
    end
  end

end
