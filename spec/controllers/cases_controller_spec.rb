require 'spec_helper'

describe CasesController do
  it "responds successfully with an HTTP 200 status code" do
    get :index
    expect(response).to be_success
    expect(response.status).to eq(200)
  end
end
