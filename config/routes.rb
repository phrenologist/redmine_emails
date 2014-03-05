RedmineApp::Application.routes.draw do
  match 'issues/:issue_id/:action/:id', :controller => 'emails'
end
