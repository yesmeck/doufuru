# encoding: utf-8

require 'mime/types'
require 'json'

module Doufuru
  class Client
    module Shuo
      def create_shuo(params = {})
        if !params[:image].nil?
          image = params[:image]
          mime_type = MIME::Types.type_for(image).first;
          params[:image] = Faraday::UploadIO.new(image, mime_type)
        end
        if !params[:attachments].nil?
          params[:attachments] = JSON.generate(params[:attachments])
        end
        post('/shuo/statuses/', params)
      end

      def timeline(params = {})
        get('/shuo/home_timeline', params)
      end

      def user_timeline(user_id, params = {})
        get("/shuo/user_timeline/#{user_id}", params)
      end
    end
  end
end
