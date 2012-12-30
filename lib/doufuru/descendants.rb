# encoding: utf-8

module Doufuru
  module Descendants
    def descendants
      ObjectSpace.each_object(::Class).select { |klass| klass < self }
    end
  end
end
