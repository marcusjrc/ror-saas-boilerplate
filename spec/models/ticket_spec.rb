require "rails_helper"

describe Ticket do
  let(:user) { FactoryBot.create(:user) }

  context "Create valid ticket" do
    it "Ticket created successfully" do
      ticket = Ticket.new(problem: "This is a problem", user: user)
      expect(ticket).to be_valid
    end

    it "Throw error when invalid parameters provided" do
      ticket = Ticket.new(problem: "", user: nil)
      expect(ticket).not_to be_valid
    end
  end

  context "Ticket destroyed successfully" do
    it "Destroyed when associated user is destroyed" do
      ticket = Ticket.new(problem: "This is a problem", user: user)
      expect(ticket.save).to be true
      user.destroy
      expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect { ticket.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
