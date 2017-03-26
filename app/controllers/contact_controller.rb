class ContactController < ApplicationController
  def index
    @contacts = Contact.all
    @categories = Category.all
  end
end
