class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)
    @contact_form.request = request
    if @contact_form.deliver
      flash[:notice] = "Message sent!"
      redirect_to new_contact_form_path
    else
      flash[:error] = "Message Error!"
      render :new
    end
  end

  private 
  def contact_form_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end
