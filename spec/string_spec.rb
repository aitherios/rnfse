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

  describe '#camelize' do
    let(:string) { Rnfse::String.new('portals') }
    let(:camelized_string) { 'Portals' }
    it { expect(string.camelize).to eq(camelized_string) }
  end

  describe '::underscore' do
    context 'quando uma palavra em CamelCase' do
      let(:string) { 'CamelCase' }
      let(:underscored_string) { 'camel_case' }
      it { expect(Rnfse::String.underscore(string)).to eq(underscored_string) }
    end
  end

  describe '#underscore' do
    let(:string) { Rnfse::String.new('CamelCase') }
    let(:underscored_string) { 'camel_case' }
    it { expect(string.underscore).to eq(underscored_string) }
  end
end
