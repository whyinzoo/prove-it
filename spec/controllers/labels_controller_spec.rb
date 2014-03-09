require 'spec_helper'

describe LabelsController do
  context "test general page retrieval" do
    it "responds successfully with an HTTP 200 status code for index page" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "responds successfully with an HTTP 200 status code for new page" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "responds successfully with an HTTP 200 status code for assign page" do
      get :assign
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  context "test create page" do
    it "successfully creates a new label with random numbers and redirects to index page" do
      fields = {
        'name' => "label - #{srand}",
        'description' => "description",
        'types' => {},
        'color' => 'red'
      }

      allow(Label).to receive(:new_label) { {"name"=>fields['name'], "description"=>"description", "enabled"=>true, "types"=>["case", "macro"], "color"=>"red", "_links"=>{"self"=>{"href"=>"/api/v2/labels/1693705", "class"=>"label"}}} }
    
      post :create, fields

      flash[:error].should be_nil
      response.should redirect_to :controller => 'labels', :action => 'index'
    end

    it "fails to create a label with no name due to invalid name and redirects back to new page" do
      fields = { 
        'name' => "",
        'description' => "description",
        'types' => {},
        'color' => 'red'
      }

      allow(Label).to receive(:new_label) { {"message"=>"Validation Failed", "errors"=>{"name"=>["blank", "invalid"]}} }
      post :create, fields

      flash[:error].should_not be_nil
      response.should redirect_to :controller => 'labels', :action => 'new'
    end
  end
end
