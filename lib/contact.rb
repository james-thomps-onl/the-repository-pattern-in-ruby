require "securerandom"

class Contact
  attr_reader :guid, :first_name, :last_name, :email
  alias_method :id, :guid

  def initialize(first_name:, last_name:, email:, guid: SecureRandom.uuid)
    raise ArgumentError unless first_name.is_a?(String) and not(first_name.empty?)
    raise ArgumentError unless last_name.is_a?(String) and not(last_name.empty?)
    raise ArgumentError unless email.is_a?(String) and not(email.empty?)
    raise ArgumentError unless guid =~ /^[A-F\d]{8}-([A-F\d]{4}-){3}[A-F\d]{12}$/i

    @guid       = guid
    @first_name = first_name
    @last_name  = last_name
    @email      = email
  end
end
