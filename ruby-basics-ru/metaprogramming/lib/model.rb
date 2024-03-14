# frozen_string_literal: true

require 'date'
# BEGIN
module Model
  def self.included(klass)
    klass.extend ClassMethods
  end

  def attributes
    @attributes
  end

  def initialize(params = {})
    @attributes = {}
    initialize_attributes params
    initialize_defaults
  end

  protected

  def initialize_defaults
    self.class.attr_defaults.each do |d|
      k = d[:attr_name]
      v = d[:attr_value]
      instance_variable_set "@#{k}", v if (instance_variable_get "@#{k}").nil?
      @attributes[k] ||= v
    end
  end

  def initialize_attributes(params = {})
    params.each do |k, v|
      if self.class.attr_names.include? k
        instance_variable_set "@#{k}", v
        @attributes[k] = send k
      end
    end
  end

  # methods for creating getter and setters by attribute:
  module ClassMethods
    def initialize
      @attribute_names = []
      @defaults = []
    end

    def attribute(name, options = {})
      default = options.fetch(:default, nil)
      @attribute_names ||= []
      @attribute_names << name

      @defaults ||= []
      @defaults << {
        attr_name: name,
        attr_value: default
      }

      define_getter(name, options)
      define_setter(name, default)
    end

    def define_getter(name, options)
      type = options.fetch(:type, :string)

      define_method name do
        var = instance_variable_get "@#{name}"
        return false if var == false
        return DateTime.parse(var) if !var.nil? && type == :datetime

        var
      end
    end

    def define_setter(name, default)
      define_method "#{name}=" do |value|
        instance_variable_set "@#{name}", value
        @attributes[name] = if default == false
                              value
                            else
                              send name
                            end
      end
    end

    def attr_names
      @attribute_names
    end

    def attr_defaults
      @defaults
    end
  end
end
# END
