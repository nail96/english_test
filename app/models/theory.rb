class Theory < ApplicationRecord
    has_one :unit

  mount_base64_uploader :image, TheoryUploader, file_name: -> (_) { 'unit' }
  validates :image, file_size: { less_than: 2.megabytes },
                    file_content_type: { allow: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }
end
