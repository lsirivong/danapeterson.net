class Page < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 1 }
  validates :slug, presence: true, length: { minimum: 1 }
end
