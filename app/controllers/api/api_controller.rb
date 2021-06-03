module Api
  class Api::ApiController < ApplicationController
    include WorkImage
    def next_image
      current_index = params[:index].to_i
      theme_id = params[:theme_id].to_i
      length = params[:length].to_i

      new_image_index = next_index(current_index, length)
      next_image_data = show_image(theme_id, new_image_index)

      respond_to do |format|
        if new_image_index.blank?
          format.html{render nothing: true, status:
            :unprocessable_entity}
          format.json {}
        else
          format.html{render display_theme, status:
            :successfully}
          format.json{render json:
                             {new_image_index: next_image_data[:index],
                              name: next_image_data[:name],
                              file: next_image_data[:file],
                              image_id: next_image_data[:image_id],
                              user_valued: next_image_data[:user_valued],
                              common_ave_value: next_image_data[:common_ave_value],
                              value: next_image_data[:value],
                              status: :successfully,
                              notice: 'Successfully listed to next'} }
        end
      end
    end
    def prev_image
      current_index = params[:index].to_i
      theme_id = params[:theme_id].to_i
      length = params[:length].to_i

      new_image_index = prev_index(current_index, length)
      prev_image_data = show_image(theme_id, new_image_index)

      respond_to do |format|
        if new_image_index.blank?
          format.html{render nothing: true, status:
            :unprocessable_entity}
          format.json {}
        else
          format.html{render display_theme, status:
            :successfully}
          format.json{render json:
                               {new_image_index: prev_image_data[:index],
                                name: prev_image_data[:name],
                                file: prev_image_data[:file],
                                image_id: prev_image_data[:image_id],
                                user_valued: prev_image_data[:user_valued],
                                common_ave_value: prev_image_data[:common_ave_value],
                                value: prev_image_data[:value],
                                status: :successfully,
                                notice: 'Successfully listed to previous'} }
        end
      end
    end
    def next_index(index, length)
      new_index = index
      index < length-1 ? new_index += 1 : new_index = 0
      new_index
    end

    def prev_index(index, length)
      new_index = index
      index > 0 ? new_index -= 1 : new_index = length-1
      new_index
    end

    def save_value
      user_id = params[:user_id].to_i
      image_id = params[:image_id].to_i
      user_valued = Value.user_valued_exists(user_id, image_id)[0] != nil;
      logger.info "IN SAVE VALUE #{user_valued}"
      value = params[:value].to_i
      new_value_data = {
        user_id: user_id,
        image_id: image_id,
        value: value
      }
      if (!user_valued)
        Value.create(new_value_data)
        new_ave_value = Value.ave_value_for(image_id)
        logger.info "ave value: #{new_ave_value.inspect}"
        image = Picture.update(image_id, {ave_value: new_ave_value})
      end

      respond_to do |format|
        if new_ave_value
          format.json {render json:
                                {
                                 name: image[:name],
                                 file: image[:file],
                                 image_id: image[:id],
                                 common_ave_value: image[:ave_value],
                                 status: :successfully,
                                  notice: 'Successfully added'
                                }
          }
        else
          format.json{render json:
                               {
                                 status: :error,
                                 notice: 'An error acquired'
                               }
          }
        end
      end
    end
  end
end
