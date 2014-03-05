class EmailsController < ApplicationController
before_filter :initialize_emails
  def initialize_emails
    @emails = Emails.new
  end

  def show_emails
    format.html { redirect_to :controller => 'issues', :action => 'show', :id => @issue }
    format.js do
      respond_to do |format|
        format.html { redirect_to :controller => 'issues', :action => 'show', :id => @issue }
        format.js { render(:update) { |page| page.replace_html "emails", :partial => 'issues/address', :locals => { :issue => @issue, :project => @project } } }
      end
    end
  end
end