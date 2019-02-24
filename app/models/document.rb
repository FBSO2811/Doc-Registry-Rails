class Document < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :attached_document

end
