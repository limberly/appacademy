include ERB::Util

module ApplicationHelper
  def csrf_token
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
  end
  
  def flash_now_error
    if flash.now[:error]
      "#{flash.now[:error]}".html_safe
    end
  end

  def ugly_lyrics(lyrics)
    lyric = "<pre>" + "&#9835; " + lyrics.split("\n").join("\n&#9835; ") + "</pre>"
    lyric.html_safe
  end
end