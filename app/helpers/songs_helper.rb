module SongsHelper
  def pretty_key(key)
    ret = key[0]

    ret += " Minor" if key[1] == "m"
    ret += " Major" if key[1] == "M"

    ret
  end
end
