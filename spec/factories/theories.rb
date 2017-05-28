FactoryGirl.define do
  factory :theory do
    image "data:image/png;base64,#{Base64.encode64(File.read(Rails.root.join("public", "images", "104.png")))}"
    links "http://youtube.com/videos/...;"
  end
end
