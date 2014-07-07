# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::String do
  describe '::camelize' do
    context 'quando uma string simples,' do
      let(:string) { 'portals' }
      let(:camelized_string) { 'Portals' }
      it { expect(Rnfse::String.camelize(string)).to eq(camelized_string) }
    end

    context 'quando uma string com undescore,' do
      let(:string) { 'portals_two' }
      let(:camelized_string) { 'PortalsTwo' }
      it { expect(Rnfse::String.camelize(string)).to eq(camelized_string) }
    end
  end
end
