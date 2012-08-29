module DataValidator
  def self.validate model
    data = model._data
    data.valid?
    data.errors.full_messages
  end
end