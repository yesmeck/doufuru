# encoding: utf-8

require "doufuru/validations/presence"
require "doufuru/validations/format"
require "doufuru/validations/token"
require "doufuru/validations/required"

module Doufuru
  module Validations

    include Presence
    include Format
    include Token
    include Required

    VALID_API_KEYS = [
      "page",
      "per_page",
      "jsonp_callback"
    ]
  end
end

