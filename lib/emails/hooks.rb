class ShowCcAddressesHook < Redmine::Hook::ViewListener
    render_on :view_issues_form_details_bottom, :partial => "issues/address/new"

end
