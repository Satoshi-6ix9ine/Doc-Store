class ValidationException < StandardError
  def initialize(variable, expected, got)
    super("Expected #{variable} to be type #{expected}, got value #{got} instead")
  end
end

module ItemErrors
  def validate_create(table_name, payload)
    raise ValidationException("table_name", "string", table_name) unless table_name.class == String
    raise ValidationExpection("payload", "hash", payload) unless payload.class = Hash
  end
end
