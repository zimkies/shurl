require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe "code generation" do
    it "creates a code" do
      short_url = ShortUrl.create(url: 'http://test.com')
      expect(short_url.code).to_not be_nil
    end
  end

  describe "code" do
    let(:existing_short_url) { create(:short_url) }

    it "doesn't allow creation of a duplicate short url" do
      new_short_url = ShortUrl.new(url: 'http://google.com', code: existing_short_url.code)
      expect(new_short_url.valid?).to eq false
    end
  end

  describe "long_url" do
    let(:short_url) { build(:short_url, url: long_url) }
    let(:long_url) { 'lkjl.com' }

    it "rejects invalid long_urls" do
      expect(short_url.valid?).to eq false
    end

    context "with a valid url" do
      let(:long_url) { 'http://google.com' }
      it "rejects valid long_urls" do
        expect(short_url.valid?).to eq true
      end
    end
  end
end
