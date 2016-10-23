class ShortUrl < ApplicationRecord
  CODE_LENGTH = 8
  URL_REGEX = /\A#{URI::regexp}\z/

  delegate :url_helpers, to: 'Rails.application.routes'
  validates :code, presence: true
  validates :url, presence: true
  validate :ensure_valid_url
  validate :ensure_url_is_not_already_shortened

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

  def ensure_url_is_not_already_shortened
    if self.url.present? && is_shortened_url?(url)
      self.errors.add(:long_url, "#{url} is already a shurl url")
    end
  end

  def is_shortened_url?(url)
    URI(url).host == Shurl::Application.default_url_options[:host]
  end

  def ensure_valid_url
    if self.url.present? && self.url !~ URL_REGEX
      self.errors.add(:long_url, "#{url} is not a valid url")
    end
  end
end
