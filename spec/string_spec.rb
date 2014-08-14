# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::String do
  describe '::camelize' do
    context 'quando uma string simples,' do
      let(:string) { 'portals' }
      let(:camelized_string) { 'Portals' }
      subject { Rnfse::String.camelize(string) }
      it { is_expected.to eq(camelized_string) }
      it { is_expected.to be_kind_of(Rnfse::String) }
    end

    context 'quando uma string com undescore,' do
      let(:string) { 'portals_two' }
      let(:camelized_string) { 'PortalsTwo' }
      subject { Rnfse::String.camelize(string) }
      it { is_expected.to eq(camelized_string) }
      it { is_expected.to be_kind_of(Rnfse::String) }
    end
  end

  describe '#camelize' do
    let(:string) { Rnfse::String.new('portals') }
    let(:camelized_string) { 'Portals' }
    subject { string.camelize }
    it { is_expected.to eq(camelized_string) }
    it { is_expected.to be_kind_of(Rnfse::String) }
  end

  describe '::underscore' do
    context 'quando uma palavra em CamelCase' do
      let(:string) { 'CamelCase' }
      let(:underscored_string) { 'camel_case' }
      subject { Rnfse::String.underscore(string) }
      it { is_expected.to eq(underscored_string) }
      it { is_expected.to be_kind_of(Rnfse::String) }
    end
  end

  describe '#underscore' do
    let(:string) { Rnfse::String.new('CamelCase') }
    let(:underscored_string) { 'camel_case' }
    subject { string.underscore }
    it { is_expected.to eq(underscored_string) }
    it { is_expected.to be_kind_of(Rnfse::String) }
  end

  describe '::demodulize' do
    let(:string) { 'Rnfse::API::Abrasf10' }
    let(:demodulized_string) { 'Abrasf10' }
    subject { Rnfse::String.demodulize(string) }
    it { is_expected.to eq(demodulized_string) }
    it { is_expected.to be_kind_of(Rnfse::String) }
  end

  describe '#demodulize' do
    let(:string) { Rnfse::String.new('Rnfse::API::Abrasf10') }
    let(:demodulized_string) { 'Abrasf10' }
    subject { string.demodulize }
    it { is_expected.to eq(demodulized_string) }
    it { is_expected.to be_kind_of(Rnfse::String) }
  end
end
