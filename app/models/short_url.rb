class ShortUrl < ApplicationRecord
  CODE_LENGTH = 8

  delegate :url_helpers, to: 'Rails.application.routes'
  validates :code, presence: true
  validates :url, presence: true

  after_initialize :assign_code

  def as_json(opts={})
    {
      url: url,
      short_url: short_url
    }
  end

  def short_url
    url_helpers.short_urls_url(code)
  end

  private

  def assign_code
    return if self.code.present?

    code = nil
    loop do
      code = SecureRandom.urlsafe_base64(CODE_LENGTH)
      break unless ShortUrl.where(code: code).exists?
    end

    self.code = code
  end
end
