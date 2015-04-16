class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)
    @contact_form.request = request
    if @contact_form.deliver
      redirect_to root_path, notice: "Message sent!"
    else
      render :new, notice: "Message failed! :("
    end
  end

  private 
  def contact_form_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end
