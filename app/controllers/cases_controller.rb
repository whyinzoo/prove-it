class CasesController < ApplicationController
  def index
    @cases = Case.first['_embedded']['entries']
  end
end
