class emails_class < ActiveRecord::Base
  belongs_to :issue
  
  validates_presence_of :emails
  validates_format_of :emails, :with => \w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*#/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  before_save :update_issue_text

  def update_issue_text
    text = issue.description = "Sent copy to e-mails [#{emails}]:\n" + issue.description;
    text.save
  end

end
