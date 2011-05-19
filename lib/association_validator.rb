class AssociationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if record.send(attribute).blank?

    attribute_string = attribute.to_s
    attribute_string[-3, 3] = ''

    classname = attribute_string.camelize.constantize
    begin
      raise "Does not exist" unless classname.find(value)
    rescue
      record.errors[attribute] = (options[:message] || "is a non existent record")
    end
  end
end
