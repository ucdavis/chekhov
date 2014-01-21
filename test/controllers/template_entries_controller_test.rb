require 'test_helper'

class TemplateEntriesControllerTest < ActionController::TestCase
  setup do
    @template_entry = template_entries(:one)
  end

    assert_redirected_to template_entries_path
  end
end
