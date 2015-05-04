authorization do
  role :admin do
    has_permission_on :templates, :to => :manage
    has_permission_on :template_entries, :to => :manage
    has_permission_on :checklists, :to => :manage
    has_permission_on :checklist_entries, :to => :manage
    has_permission_on :comments, :to => :manage
    has_permission_on :analytics, :to => :manage
    has_permission_on :checklist_categories, :to => :manage
    has_permission_on :template_categories, :to => :manage
  end
  role :access do
    has_permission_on :templates, :to => :read
    has_permission_on :checklists, :to => [:index, :create]
    has_permission_on :checklists, :to => :manage do
      if_attribute :user => is { user }
    end
    has_permission_on :checklists, :to => :use do
      if_attribute :public => true
    end
    has_permission_on :checklist_entries, :to => :manage do
      if_permitted_to :use, :checklist
      if_permitted_to :manage, :checklist
    end
    has_permission_on :comments, :to => [:index, :create] do
      if_permitted_to :use, :checklist
      if_permitted_to :manage, :checklist
    end
    has_permission_on :checklist_categories, :to => :read
    has_permission_on :template_categories, :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  privilege :use, :includes => [:read, :update]
end
