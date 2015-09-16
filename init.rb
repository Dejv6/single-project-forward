require 'redmine'
require 'welcome_controller_patch'

Redmine::Plugin.register :single_project_forward do
  name 'Single Project Forward'
  author 'James Kassemi'
  url 'http://github.com/jkassemi/single-project-forward'
  author_url 'http://tweekedideas.com/'
  description 'Forward a Redmine user to a single project page if only access to this project is available.'
  version '0.1'

  requires_redmine :version_or_higher => '0.8.0'

  Rails.configuration.to_prepare do 
    # This tells the Redmine version's controller to include the module from the file above.
    WelcomeController.send(:include, ForwardIfSingleWelcomeControllerPatch)
  end

end
