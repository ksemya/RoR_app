module WorkImage
  extend ActiveSupport::Concern

  include WorkHelper
  def show_image(theme_id, image_index)
    theme_images = Picture.theme_images(theme_id)

    current_user_id = current_user.id
    one_image_attr = theme_images[image_index].attributes
    image_id = one_image_attr["id"]
    value = Value.user_valued_exists(current_user_id, image_id)[0]
    user_valued = value != nil
    values_qty = Value.all.count.round
    if user_valued
      common_ave_value = Picture.find_image(image_id).pluck(:ave_value)[0]
      if common_ave_value.blank?
        common_ave_value = 0
      end
      common_ave_value.round unless common_ave_value.blank?
    else
      common_ave_value = 0
    end

    data = { index: image_index,
             values_qty: values_qty,
             current_user_id: current_user_id,
             theme_id: theme_id,
             images_arr_size: theme_images.size,
             image_id: image_id,
             name: one_image_attr["name"],
             file: one_image_attr["file"],
             user_valued: user_valued,
             value: value,
             common_ave_value: common_ave_value
    }
    logger.info "In show_image:  data = #{data.inspect} "
    data
  end
end


