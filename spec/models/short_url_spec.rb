require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe "code generation" do
    it "creates a code" do
      short_url = ShortUrl.create(url: 'http://test.com')
      expect(short_url.code).to_not be_nil
    end
  end
end
