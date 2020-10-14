require 'rails_helper'

RSpec.describe "ScrapperService", type: :service do
  context "#title" do
    subject { ScrapperService.new(url) }
    let(:url) { 'https://google.com' }

    it 'returns the given URL page title' do
      expect(subject.title).to be_an(String)
      expect(subject.title).to eq('Google')
    end
  end
end