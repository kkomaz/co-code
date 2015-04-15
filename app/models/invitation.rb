class Invitation < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :lesson

  def self.create_invitations(lesson, invitees)
    invitees.each do |invitee|
      Invitation.create(:lesson => lesson, :user => invitee)
    end
  end
  
end
