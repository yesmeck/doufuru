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

      def event_user_participated(user_id, params = {})
        get("/event/user_participated/#{user_id}", params).events
      end

      def event_user_wished(user_id, params = {})
        get("/event/user_wished/#{user_id}", params).events
      end

      def event_list(params = {})
        get("/event/list", params).events
      end

      def loc(loc_id, params = {})
        get("/loc/#{loc_id}", params)
      end

      def loc_list(params = {})
        get("/loc/list", params).locs
      end

      def participate_event(id, params = {})
        response = post("/event/#{id}/participants", params, true)
        if response == '{}'
          response = 'ok'
        end
        response
      end

      def delete_participated_event(event_id, params = {})
        response = delete("/event/#{event_id}/participants", params, true)
        if response == '{}'
          response = 'ok'
        end
        response
      end

      def wish_event(event_id, params = {})
        response = post("/event/#{event_id}/wishers", params, true)
        if response == '{}'
          response = 'ok'
        end
        response
      end

      def delete_wished_event(event_id, params = {})
        response = delete("/event/#{event_id}/wishers", params, true)
        if response == '{}'
          response = 'ok'
        end
        response
      end
    end
  end
end
