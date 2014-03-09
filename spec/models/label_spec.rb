require 'spec_helper'

describe Label do
  it "should retrieve a list of labels" do
    labels = Label.all
    labels['total_entries'].should >= 0
  end

  it "successfully creates a new label with random numbers" do
    fields = {
      'name' => "label - #{srand}",
      'description' => "description",
      'types' => {},
      'color' => 'red'
    }

    label = Label.new_label(fields)
    label['_links']['self']['href'].should_not be_empty
  end

  it "fails to create a lable with no name" do
    fields = {
      'name' => "",
      'description' => "description",
      'types' => {},
      'color' => 'red'
    }

    label = Label.new_label(fields)
    label['message'].should eq("Validation Failed")
  end

  it "fails to create labels with duplicate names" do
    fields = {
      'name' => "label - #{srand}",
      'description' => "description",
      'types' => {},
      'color' => 'red'
    }

    label = Label.new_label(fields)
    label['_links']['self']['href'].should_not be_empty

    label2 = Label.new_label(fields)
    label2['message'].should_not be_empty
  end

  it "creates a label with a very long name and truncates it" do
    fields = {
      'name' => "label - #{srand}" * 1000,
      'description' => "description",
      'types' => {},
      'color' => 'red'
    }

    label = Label.new_label(fields)
    label['_links']['self']['href'].should_not be_empty
  end

  it "should not create a label with special characters" do
    fields = {
      'name' => "aa!@#%^&*() - #{srand}",
      'description' => "description",
      'types' => {},
      'color' => 'red'
    }

    label = Label.new_label(fields)
    label['message'].should_not be_empty
  end

end
