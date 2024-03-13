# frozen_string_literal: true

require 'forwardable'
require 'uri'

# BEGIN
class Url
  include Comparable
  extend Forwardable

  attr_reader :query_params

  def initialize(url)
    @url = URI url
    query = @url.query || ''

    @query_params = Hash[URI.decode_www_form(query).map { |el| [el[0].to_sym, el[1]] }]
  end

  def query_param(key, default = nil)
    query_params.fetch(key, default)
  end

  def ==(other)
    other.scheme == @url.scheme &&
      other.host == @url.host &&
      other.port == @url.port &&
      other.query_params == query_params
  end

  def_delegator :@url, :scheme
  def_delegator :@url, :port
  def_delegator :@url, :host
end

u = Url.new 'http://yandex.ru?a=1&b=2'
p u
u = Url.new 'http://yandex.ru'
p u
# END
