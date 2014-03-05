module Emails
  module MailerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        alias_method_chain :issue_add, :emails
        alias_method_chain :issue_edit, :emails
      end
    end

    module InstanceMethods
      # Overrides the issue_edit method which is only
      # be called on existing tickets. We will add the
      # owner-email to the recipients only if no email-
      # footer text is available.

      def issue_add_with_emails(issue)
      issue_add_without_email_filter(issue)
      end

      def issue_edit_with_emails(journal, to_users=[], cc_users=[])
        issue = journal.journalized.reload
        redmine_headers 'Project' => issue.project.identifier,
                        'Issue-Id' => issue.id,
                        'Issue-Author' => issue.author.login
        redmine_headers 'Issue-Assignee' => issue.assigned_to.login if issue.assigned_to
        message_id journal
        references issue
        @author = journal.user
        
        other_recipients = []
        # add owner-email to the recipients
        begin
            p = issue.project
            owner_email = emails.value
            if !emails.blank? && !f.nil? && !p.nil?
              other_recipients << emails
            end
          rescue Exception => e
          mylogger.error "Error while adding emails to recipients of email notification: \"#{e.message}\"."
        end
        s = "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] "
        s << "(#{issue.status.name}) " if journal.new_value_for('status_id')
        s << issue.subject
        @issue = issue
        @users = to_users + cc_users + other_recipients
        @journal = journal
        @journal_details = journal.visible_details(@users.first)
        mail(
          :to => to_users.map(&:mail),
          :cc => cc_users.map(&:mail),
          :subject => s
        )
      end
      
    end # module InstanceMethods
  end # module MailerPatch
end # module RedmineHelpdesk

# Add module to Mailer class
Mailer.send(:include, Emails::MailerPatch)