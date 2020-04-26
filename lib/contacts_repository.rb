require "singleton"
require "contact"

class ContactsRepository
  include Singleton

  def initialize
    @store = Hash.new
  end

  def <<(contact)
    raise ArgumentError unless contact.is_a?(Contact)
    @store[contact.id] = contact
  end

  def [](identifier)
    @store[identifier]
  end
end
