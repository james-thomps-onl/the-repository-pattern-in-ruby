require "spec_helper"
require "securerandom"
require "contact"

RSpec.describe Contact do
  subject { Contact.new(first_name: "John", last_name: "Doe", email: "jdoe@example.org") }

  its(:first_name) { is_expected.to eq "John" }
  its(:last_name) { is_expected.to eq "Doe" }
  its(:email) { is_expected.to eq "jdoe@example.org" }
  its(:guid) { is_expected.to match(/^[A-F\d]{8}-([A-F\d]{4}-){3}[A-F\d]{12}$/i) }
  its(:id) { is_expected.to equal subject.guid }

  it "raises an error with a blank first name" do
    expect {
      Contact.new(first_name: "", last_name: "Doe", email: "jdoe@example.org")
    }.to raise_error(ArgumentError)
  end

  it "raises an error with a non-string first name" do
    expect {
      Contact.new(first_name: nil, last_name: "Doe", email: "jdoe@example.org")
    }.to raise_error(ArgumentError)
  end

  it "raises an error with a blank last name" do
    expect {
      Contact.new(first_name: "John", last_name: "", email: "jdoe@example.org")
    }.to raise_error(ArgumentError)
  end

  it "raises an error with a non-string last name" do
    expect {
      Contact.new(first_name: "John", last_name: nil, email: "jdoe@example.org")
    }.to raise_error(ArgumentError)
  end

  it "raises an error with a blank email" do
    expect {
      Contact.new(first_name: "John", last_name: "Doe", email: "")
    }.to raise_error(ArgumentError)
  end

  it "raises an error with a non-string email" do
    expect {
      Contact.new(first_name: "John", last_name: "Doe", email: nil)
    }.to raise_error(ArgumentError)
  end

  it "raises an error with a ill-formed guid" do
    expect {
      Contact.new(guid: "TRASH-TRASH-1234", first_name: "John", last_name: "Doe", email: "jdoe@example.org")
    }.to raise_error(ArgumentError)
  end

  context "when a guid is provided to new" do
    subject { Contact.new(first_name: "John", last_name: "Doe", email: "jdoe@example.org", guid: supplied_guid) }
    let(:supplied_guid) { SecureRandom.uuid }

    its(:guid) { is_expected.to eq supplied_guid }
    its(:id) { is_expected.to eq supplied_guid }
  end
end
