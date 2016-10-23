require "rails_helper"

RSpec.describe "/api/short_urls", :type => :request do
  describe "POST /api/short_urls" do
    subject { post url, params: {url: long_url } }
    let(:url) { '/api/short_urls' }
    let(:long_url) { 'https://longurl.com'}

    it "creates a short url and returns the shortened url" do
      subject

      expect(response.status).to eq 200
      expect(ShortUrl.count).to eq(1)

      expect(JSON.parse(response.body)).to eq({
        'url' => long_url,
        'short_url' => ShortUrl.last.short_url,
      })
    end

    context "with an invalid url" do
      let(:long_url) { 'notaurl' }

      it "returns an error" do
        subject

        expect(response.status).to eq 422
        expect(ShortUrl.count).to eq(0)

        expect(response.body).to match /valid url/
      end
    end

    context "with a url that's already shortened" do
      let(:long_url) { create(:short_url).short_url }

      it "returns an error" do
        subject

        expect(response.status).to eq 422
        expect(ShortUrl.count).to eq(1)

        expect(response.body).to match /already/
      end
    end
  end

  describe "GET /:code" do
    let(:short_url) { create(:short_url) }
    it "creates a short url and returns the shortened url" do
      get "/#{short_url.code}"

      expect(response.status).to eq 302
      expect(response.location).to eq short_url.url
    end
  end
end
