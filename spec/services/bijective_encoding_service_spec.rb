require 'rails_helper'

RSpec.describe "BijectiveEncodingService", type: :service do
  context ".encode" do
    it "converts an integer into a given base62 alphabet string" do
      expect(BijectiveEncodingService.encode(0)).to be_an(String)
    end

    it "always eq the same integer to the same string" do
      expect(BijectiveEncodingService.encode(1)).to eq("b")
      expect(BijectiveEncodingService.encode(1)).to eq("b")
    end
  end

  context ".decode" do
    it "converts a given string into am integer ID" do
      expect(BijectiveEncodingService.decode("a")).to be_an(Integer)
    end
  end
end
