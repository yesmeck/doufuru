# encoding: utf-8

require "doufuru/connection"
require "doufuru/request"
require "doufuru/normalizer"
require "doufuru/parameter_filter"
require "doufuru/validations"

module Doufuru
  class API

    include Connection
    include Request
    include Normalizer
    include ParameterFilter
    include Validations

    attr_reader *Configuration::VALID_OPTIONS_KEYS

    # Callback to update global configuration options
    class_eval do
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          Doufuru.send("#{key}=", arg)
        end
      end
    end

    def initialize(options = {}, &block)
      super()
      setup options
      set_api_client

      self.instance_eval(&block) if block_given?
    end

    def setup(options = {})
      options = Doufuru.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def set_api_client
      Doufuru.api_client = self
    end

    # Responds to attribute query or attribute clear
    def method_missing(method, *args, &block) # :nodoc:
      case method.to_s
      when /^(.*)\?$/
        return !self.send($1.to_s).nil?
      when /^clear_(.*)$/
        self.send("#{$1.to_s}=", nil)
      else
        super
      end
    end

    # Set an option to a given value
    def set(option, value=(not_set = true), &block)
      raise ArgumentError, 'value not set' if block and !not_set

      if not_set
        set_options option
        return self
      end

      if respond_to?("#{option}=")
        return __send__("#{option}=", value)
      end

      self
    end

    # Returns all API public methods for a given class.
    def self.inherited(klass)
      klass.class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def self.actions
          self.new.api_methods_in(#{klass})
        end
        def actions
          api_methods_in(#{klass})
        end
      RUBY_EVAL
      super
    end

    def api_methods_in(klass)
      puts "---"
      (klass.send(:instance_methods, false) - ['actions']).sort.each do |method|
        puts "|--> #{method}"
      end
      klass.included_modules.each do |mod|
        if mod.to_s =~ /#{klass}/
          puts "| \\ #{mod.to_s}"
          mod.instance_methods(false).each do |met|
            puts "|  |--> #{met}"
          end
          puts "| /"
        end
      end
      puts "---"
      nil
    end

    private

    # Set multiple options
    def set_options(options)
      unless options.respond_to?(:each)
        raise ArgumentError, 'cannot iterate over value'
      end
      options.each { |key, value| set(key, value) }
    end
  end
end
