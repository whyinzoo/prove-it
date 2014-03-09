class LabelsController < ApplicationController
  def index
    @labels = Label.all['_embedded']['entries']
  end

  def new

  end

  def create
    name = params['name'] 
    description = params['description']
    color = params['color']
    types = (params['type'] || {}).delete_if { |k,v| v == '0' }

    fields = {
      'name' => name,
      'description' => description,
      'color' => color,
      'types' => types.keys
    }

    label = Label.new_label(fields)

    #check for errors, if errors exist during api call, redirect back to new page and flash error
    if label['errors'].nil?
      redirect_to :controller => 'labels', :action => 'index'
    else 
      flash[:error] = label['errors'].keys.inject("") { |msg, k| msg << "#{k} : #{label['errors'][k].join(',')}"} 
      redirect_to :controller => 'labels', :action => 'new'
    end
  end

  def assign
    @labels = Label.all['_embedded']['entries'].inject("") do |options, label| 
      options << "<option value='#{label['name']}' #{'disabled' unless label['enabled']}>#{label['name']}</option>"
    end
 
    @cases = Case.first['_embedded']['entries'].inject("") { |options, c| options << "<option value='#{c['id']}'>#{c['subject']}</option>" }
  end

  def update
    c = params['case']
    label = params['label']
    Case.append(c, label)
    
    redirect_to :controller => 'cases', :action => 'index'
  end
end
