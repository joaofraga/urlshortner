require 'rails_helper'

RSpec.describe "MainController", type: :request do
  context "GET #home" do
    before(:each) do
      get '/home'
    end

    it "displays an input to add the URL to be shortned" do
      parsed_body = Nokogiri::HTML(response.body)
      expect(parsed_body.css('input#url_original')).to be_present
    end
  end
  context "POST #create" do
    context "when is a valid URL" do
      it "returns shortned URL" do
        post '/create', params: { url: { original: 'https://google.com' } }
        url = Url.last

        expect(response.body).to include(url.short)
      end
    end

    context "when URL is not valid" do
      it "returns 400 bad request header" do
        post '/create', params: { url: { original: 'badurl.com' } }
        expect(response.status).to eq(400)
      end
    end
  end

  context "GET #show" do
    context "when is a valid short code" do
      let(:original) { 'https://google.com' }
      let(:url) { Url.create(original: original) }

      it "redirects to original URL" do
        get "/#{url.short}"
        expect(response).to redirect_to(original)
      end

      it "increment views count for urls" do
        expect(url.views).to eq(0)
        get "/#{url.short}"
        expect(url.reload.views).to eq(1)
      end
    end

    context "when it is not a valid short code" do
      it "returns a 404 error page" do
        expect { get "/123312213312" }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
