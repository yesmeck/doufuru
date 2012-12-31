# encoding: utf-8

module Doufuru
  class Books < API

    def self.new(*args)
      if !args.empty?
        return super({}).get(args[0])
      else
        return super
      end
    end

    def initialize(options = {})
      super options
    end

    def user
      @user ||= ApiFactory.new "Books::User"
    end

    def tags(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}/tags").tags
    end

    def get(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}", params)
    end
    alias :find :get

    def get_by_isbn(isbn, params = {})
      set :isbn => isbn
      assert_presence_of isbn
      normalize! params

      get_request("/book/isbn/#{isbn}", params)
    end
    alias :find_by_isbn :get_by_isbn

    def search(params = {})
      normalize! params
      assert_presence_of params["q"] if params["tag"].nil?
      assert_presence_of params["tag"] if params["q"].nil?

      get_request("/book/search", params).books
    end

    def collection(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}/collection")
    end

    def annotations(id, params = {})
      set :id => id
      assert_presence_of id
      normalize! params

      get_request("/book/#{id}/annotations").annotations
    end

    def annotation(annotation_id, params = {})
      set :annotation_id => annotation_id
      assert_presence_of annotation_id
      normalize! params

      get_request("/book/annotation/#{annotation_id}")
    end

  end
end
