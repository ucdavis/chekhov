class AddTemplateCategoryRefToTemplates < ActiveRecord::Migration
  def change
    add_reference :templates, :template_category, index: true, foreign_key: true
  end
end
