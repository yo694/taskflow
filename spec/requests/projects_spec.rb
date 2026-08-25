require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "GET /index" do
    it "redirects unauthenticated users to sign in" do
      get projects_path

      expect(response).to redirect_to(new_user_session_path)
    end

    it "denies access to a non-member" do
      user = create(:user)
      other_user = create(:user)
      project = create(:project, owner: other_user)

      sign_in user

      get project_path(project)

      expect(response).to redirect_to(root_path)
    end
  end
end