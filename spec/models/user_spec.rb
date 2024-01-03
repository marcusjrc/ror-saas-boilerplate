describe User do
  before do
    allow_any_instance_of(Subscription).to receive(:create_notification)
  end

  context "Creates valid User" do
    it "User created successfully" do
      user = build(:user, email: "uniqueemail@test.com")
      expect(user.save).to be true
    end

    it "Throw error when user email already taken" do
      user = build(:user, email: "same_email@test.com")
      user.save
      user_two = build(:user, email: "same_email@test.com")
      expect(user_two.save).to be false
    end
  end
  context ".subscribed?" do
    it "returns true when user subscribed and not past period end" do
      user = create(:user, :with_subscription, first_name: "Jim")
      expect(user.subscribed?).to be true
    end

    it "returns false when user subscription is not active or trialing" do
      user = create(:user, :with_subscription, first_name: "Jack")
      user.subscription.status = "paused"
      user.subscription.save
      expect(user.subscribed?).to be false
    end

    it "returns false when user is past their current period end" do
      user = create(:user, :with_subscription, first_name: "Jack")
      user.subscription.current_period_end = 2.days.ago
      user.subscription.save
      expect(user.subscribed?).to be false
    end
  end
end
