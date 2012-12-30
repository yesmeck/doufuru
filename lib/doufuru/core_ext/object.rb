# encoding: utf-8

class Object
  def require(file)
    super if file != "parts"
  end
end

