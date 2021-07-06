FactoryBot.define do
  factory :url do
    url { "http://random.url" }
    code { "#{rand(1000)}-random-code" }
  end
end
