class Invitation < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :lesson

  validates :user, :lesson, presence: true

  def self.create_invitations(lesson, invitees)
    invitees.each do |invitee|
      if invitee != ""
        @user = User.find(invitee)
        Invitation.create(:lesson => lesson, :user => @user)
      end
    end
  end

end
