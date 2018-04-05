require "looop_docstore/version"
require "looop_docstore/item"
require "looop_docstore/table"

module Docstore
  class << self
    def configure_client(params)
      @defaults = {
        # http_open_timeout: 5,
        # http_read_timeout: 5,
        retry_limit: 5
      }
      @client = Aws::DynamoDB::Client.new(params.merge(@defaults))
    end

    def client
      @client ||= nil
    end
  end
  extend Item
  extend Table
end
