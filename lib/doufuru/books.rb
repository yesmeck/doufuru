# encoding: utf-8

module Doufuru
  class Books < API

    def self.new(*args)
      args = [{}] if args.empty?
      if !args.empty? && !args[0].is_a?(Hash)
        return super({}).get(args[0])
      else
        return super(args[0])
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

    def collection(*args)
      args = [{}] if args.empty?
      if !args.empty? && !args[0].is_a?(Hash)
        return Books::Collection.new({}).get(args[0])
      else
        @collection ||= ApiFactory.new "Books::Collection"
        return @collection
      end
    end

    def annotations(id, params = {})
      @annotation ||= ApiFactory.new "Books::Annotation"
      @annotation.list(id, params)
    end

    def annotation(*args)
      args = [{}] if args.empty?
      if !args.empty? && !args[0].is_a?(Hash)
        return Books::Annotation.new({}).get(args[0])
      else
        @annotation ||= ApiFactory.new "Books::Annotation"
        return @annotation
      end
    end

    def review(*args)
      args = [{}] if args.empty?
      if !args.empty? && !args[0].is_a?(Hash)
        return Books::Review.new({}).get(args[0])
      else
        @review ||= ApiFactory.new "Books::Review"
        return @review
      end
    end

  end
end
