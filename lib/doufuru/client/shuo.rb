# encoding: utf-8

require 'mime/types'

module Doufuru
  class Client
    module Shuo
      def create_shuo(params = {})
        if !params[:image].nil?
          image = params[:image]
          mime_type = MIME::Types.type_for(image).first;
          params[:image] = Faraday::UploadIO.new(image, mime_type)
        end
        post('/shuo/statuses/', params)
      end
    end
  end
end
