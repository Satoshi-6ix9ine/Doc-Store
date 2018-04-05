require 'aws-sdk-core'
require 'looop_docstore/errors'

module Docstore
  module Item
    class << self
      # extend DocStore::ItemErrors

      def client
        Docstore.client
      end

      def create(table_name, options)
        # validate_create(table_name, payload)
        # Have a set sit in front of the cache for all uuids of a table to check UUID
        object_id = options[:hash_key] || SecureRandom.uuid
        options.merge!({object_id: object_id.to_s})
        # self.dynamodb_execute {
        client.put_item({
          table_name: table_name,
          item: options
        })
        object_id
        # }
      end

      def get(table_name, object_id, *attrs_to_get)
        opts = {
          table_name: table_name,
          key: { object_id: object_id.to_s }
        }
        unless attrs_to_get.empty?
          opts.merge!({ attributes_to_get: attrs_to_get })
        end

        # self.dynamodb_execute {
          client.get_item(opts).item
        # }

      end

      ## Figure out later best way to build in UpdateExpressions for nested attrs
      ## perhaps pass in update set like
      # {
      #   set: {
      #     age: 7,
      #     favorite_list['new_list']: [1, 2, 3]
      #   },
      #   remove: [
      #     friends[3],
      #     {favorite_list['old_list'][2]}}
      #   ]
      # }
      # update_str = "SET"
      # attrs_to_update.each do |k, v|
      #   update_str += " #{k}=:#{v}"
      # end
      def update(table_name, object_id, attrs_to_update)

        attrs_to_update.each do |k, v|
          attrs_to_update[k] = {value: v, action: "PUT"}
        end

        opts = {
          table_name: table_name,
          key: { object_id: object_id },
          attribute_updates: attrs_to_update, #deprecated
          return_values: "ALL_NEW"
          # update_expression: update_str
        }

        # self.dynamodb_execute {
          client.update_item(opts).attributes
        # }

      end

      def delete(table_name, object_id)
        opts = {
          table_name: table_name,
          key: { object_id: object_id },
          return_values: "ALL_OLD"
        }

        # self.dynamodb_execute {
          client.delete_item(opts).attributes
        #  }
      end

      #Maybe make calls from docstore instance instead of class?
      #Then you can privatize the method(s) below:

      def dynamodb_execute
        begin
          yield
        rescue => error
          return error
        end
      end

    end
  end
end
