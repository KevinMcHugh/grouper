class SelectorController < ApplicationController
  def index
    @groups = GroupSelector.select Person.all
  end
end
