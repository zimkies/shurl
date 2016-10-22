# This will guess the User class
FactoryGirl.define do
  factory :short_url do
    sequence(:code) { |i| "code#{i}" }
    sequence(:url) { |i| "http://url.com/#{i}"}
  end
end
