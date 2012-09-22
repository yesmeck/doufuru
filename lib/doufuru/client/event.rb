# encoding: utf-8

module Doufuru
  class Client
    module Event
      def event(id, params = {})
        get("/event/#{id}", params)
      end

      def event_participants(id, params = {})
        get("/event/#{id}/participants", params).users
      end

      def event_wishers(id, params = {})
        get("/event/#{id}/wishers", params).users
      end

      def event_user_created(user_id, params = {})
        get("/event/user_created/#{user_id}", params).events
      end

      def event_user_participanted(user_id, params = {})
        get("/event/user_participanted/#{user_id}", params).events
      end

      def event_user_wished(user_id, params = {})
        get("/event/user_wished/#{user_id}", params).events
      end

      def event_list(params = {})
        get("/event/list", params).events
      end
    end
  end
end
