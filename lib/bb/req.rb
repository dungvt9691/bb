#
require "active_support/all"
require "net/http"
require "pry"

module BB

  module Req

    # Send GET request
    # @param uri [String]
    # @param header [Hash]
    # @return [Hash]
    def self.get(uri, header = {})
      header['Content-Type']    ||= 'application/json'

      uri = URI(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      http.set_debug_output($stdout) if ENV["VERBOSE"]

      req = Net::HTTP::Get.new(uri)
      header.keys.each do |k|
        req.add_field(k, header[k])
      end

      res = http.request(req)
      return ActiveSupport::JSON.decode(res.body)
    end

    # Send POST request
    # @param uri [String]
    # @param data [Hash]
    # @param header [Hash]
    # @return [Hash]
    def self.post(uri, data = {}, header = {})
      header['Content-Type']    ||= 'application/json'

      uri = URI(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      http.set_debug_output($stdout) if ENV["VERBOSE"]

      req = Net::HTTP::Post.new(uri)
      req.body = ActiveSupport::JSON.encode(data)

      header.keys.each do |k|
        req.add_field(k, header[k])
      end

      res = http.request(req)

      return ActiveSupport::JSON.decode(res.body)
    end

    # Send DELETE request
    # @param uri [String]
    # @param header [Hash]
    # @return [Hash]
    def self.delete(uri, header = {})
      header['Content-Type']    ||= 'application/json'

      uri = URI(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      http.set_debug_output($stdout) if ENV["VERBOSE"]

      req = Net::HTTP::Delete.new(uri)
      header.keys.each do |k|
        req.add_field(k, header[k])
      end

      res = http.request(req)
      return ActiveSupport::JSON.decode(res.body)
    end

  end

end
