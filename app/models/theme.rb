class Theme < ApplicationRecord
  has_many :pictures
  scope :find_theme_id, -> (theme) {
    find_by_name(theme).id
  }
end
