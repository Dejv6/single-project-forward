require_dependency 'welcome_controller'  


module ForwardIfSingleWelcomeControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method_chain :index, :forward_if_single
    end
  end

  module InstanceMethods
    # Adds a rates tab to the user administration page
    def index_with_forward_if_single
      tabs = index_without_forward_if_single
      scope = Project.visible.sorted
      @projects = scope.active.to_a
      if @projects.length == 1
        redirect_to(:controller => "projects", :action => "show", :id => @projects.first)
        return false
      end
    end
  end
end

