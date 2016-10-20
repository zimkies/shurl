require "rails_helper"

RSpec.describe "/api/short_urls", :type => :request do
  describe "POST /api/short_urls" do
    let(:url) { '/api/short_urls' }
    let(:long_url) { 'https://longurl.com'}

    it "creates a short url and returns the shortened url" do
      post url, params: {url: long_url }

      expect(response.status).to eq 200
      expect(ShortUrl.count).to eq(1)

      expect(JSON.parse(response.body)).to eq({
        'url' => long_url,
        'short_url' => ShortUrl.last.short_url,
      })
    end
  end
end
