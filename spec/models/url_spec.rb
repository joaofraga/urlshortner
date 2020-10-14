require 'rails_helper'

RSpec.describe Url, type: :model do
  context "after creating" do
    it "adds the short code to the url" do
      url = Url.new(original: 'https://google.com')
      expect { url.save }.to change { url.short }.from(nil)
    end
  end

  context "before creating" do
    it "scraps original page title and stores it" do
      url = Url.new(original: 'https://google.com')
      expect { url.save }.to change { url.title }.from(nil).to('Google')
    end
  end

  context "#count_view! " do
    it "increments views by one" do
      url = Url.create(original: 'https://google.com')
      expect { url.count_view! }.to change { url.views }.from(0).to(1)
    end
  end
end
