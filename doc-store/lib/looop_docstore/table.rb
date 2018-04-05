require 'aws-sdk-core'
require 'looop_docstore/errors'

module Docstore
  module Table
    class << self
      def client
        Docstore.client
      end

      def create_table(opts)
        client.create_table({
          attribute_definitions: [ { attribute_name: "object_id", attribute_type: "S" } ],
          table_name: opts[:table_name],
          key_schema: [ {attribute_name: "object_id", key_type: "HASH" } ],
          provisioned_throughput: provisioned_throughput(opts)
        })
        # client.create_table(build_params(opts))
      end

      def attribute_definitions(opts)
        # return [attribute_name: opts[:hash_key], attribute_type: 'S' }]
        results = []
        results << { attribute_name: opts[:hash_key], attribute_type: 'S' }
        if opts[:range_key]
          results << { attribute_name: opts[:range_key], attribute_type: 'S' }
        end
        results
      end

      def key_schema(opts)
        # return [{ attribute_name: opts[:hash_key], key_type: "HASH" }]
        results = []
        results << { attribute_name: opts[:hash_key], key_type: "HASH" }
        if opts[:range_key]
          results << { attribute_name: opts[:range_key], key_type: "RANGE" }
        end
        results
      end

      def provisioned_throughput(opts)
        {
          read_capacity_units: opts[:read_units] || 1,
          write_capacity_units: opts[:write_units] || 1
        }
      end

      def print_opts
        puts JSON.pretty_generate(self.to_h)
      end

      private

      def build_params(opts)
        attribute_definitions = attribute_definitions(opts)
        key_schema = key_schema(opts)
        table_name = opts[:table_name]
        provisioned_throughput = provisioned_throughput(opts)

        {
          attribute_definitions: attribute_definitions,
          table_name: table_name,
          key_schema: key_schema,
          provisioned_throughput: provisioned_throughput
        }
      end
    end
  end
end
