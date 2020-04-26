require "spec_helper"
require "contacts_repository"
require "contact"

RSpec.describe ContactsRepository do
  subject { ContactsRepository.instance }

  context "when a Contact has been previously added" do
    let(:contact) { Contact.new(first_name: "John", last_name: "Doe", email: "jdoe@example.org") }

    before do
      subject << contact
    end

    it "can be retrieved by its guid" do
      expect(subject[contact.id]).to be contact
    end
  end

  context "when attempting to add something besides a Contact" do
    it "raises an error" do
      expect {
        subject << Object.new
      }.to raise_error(ArgumentError)
    end
  end
end
