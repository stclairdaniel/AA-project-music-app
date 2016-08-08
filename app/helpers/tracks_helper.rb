module TracksHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    lyrics_lines = lyrics.split("\n")
    res = ""
    lyrics_lines.each do |line|
      res << "<pre>&#9835; #{h(line)}</pre>"
    end
    res.html_safe
  end

end
