Testing:
  - Unit/Integration testing for item.rb and table.rb

Features:
  NEW:
    - Table::#delete, Table::#update

  UPDATE:
    - Change BigDecimal return values to integers
    - Item::#update
      - Change the way functions are called to fit       update_expression
    - Add validations, error handling, in all of the code
    - Automatically generate batch requests
    - Automatically adjust throughput options
    - Automatically generate distributed table keys
    - Somewhere in the future:
      - Handle nested documents as refs that point to     separate tables automatically generated & managed with a caching layer (Elasticache?)
    - OR/AND Automatically generate GSI/LSI indexes
    - Build query language to handle cross table scans efficiently

  DEPRECATE:
    - Item::#update
      - deprecate :attribute_updates params
