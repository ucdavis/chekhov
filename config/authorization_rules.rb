authorization do
  role :admin do
    has_permission_on :templates, :to => :manage
    has_permission_on :checklists, :to => :manage
  end
  role :access do
    has_permission_on :templates, :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
