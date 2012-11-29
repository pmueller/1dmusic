module SongsHelper
  def pretty_key(key)
    return "No key set" if key.nil?

    ret = key[0]

    ret += " Minor" if key[1] == "m"
    ret += " Major" if key[1] == "M"
    ret += " Harmonic" if key[1] == "h"

    ret
  end
end
