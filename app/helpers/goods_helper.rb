module GoodsHelper

  def good_image(good)
    if good.photos.any? 
      image_tag good.photos.first.file.thumb.url, alt: good.name
    else
      image_tag 'photo-not-available.png'
    end
  end

  def good_image_small(good)
    if good.photos.first
      image_tag good.photos.first.file.small_thumb.url alt: good.name
    else
      "w/o photo"
    end
  end

  def href_for_lightbox(good)
    if good.photos.empty?
      '#'
    else
      "#{good.photos.first.file.url}"
    end
  end

end
