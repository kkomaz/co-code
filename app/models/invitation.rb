class Invitation < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :lesson


  def self.active_invitations(user)

  def self.create_invitations(lesson, invitees)
    invitees.each do |invitee|
      if invitee != ""
        @user = User.find(invitee)
        Invitation.create(:lesson => lesson, :user => @user)
      end
    end
  end

end
