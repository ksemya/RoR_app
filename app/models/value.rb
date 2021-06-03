class Value < ApplicationRecord
  belongs_to :user

  def self.user_valued_exists(current_user_id, image_id)
    value = where(user_id: current_user_id, image_id: image_id).pluck("value");
    return value
  end

  def self.ave_value_for(image_id)
    values = where(image_id: image_id).pluck("value")
    sum = values.inject(:+)
    ave_value = sum/values.size
    return  ave_value
  end

end
