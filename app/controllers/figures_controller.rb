class FiguresController < ApplicationController

  get '/figures/new' do
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each do |title_id|
        FigureTitle.create(title_id: title_id, figure_id: @figure.id)
      end
      binding.pry
    else #params[:title][:name]
      @title = Title.create(params[:title])
      @figure_title = FigureTitle.create(title_id: @title.id, figure_id: @figure.id)
      binding.pry
    end
    # binding.pry
    if !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each do |landmark_id|
        # binding.pry
        @landmark = Landmark.find_by_id(landmark_id)
        @landmark.figure_id = @figure.id
      end
    elsif (params[:landmark][:name] != "") && (params[:landmark][:year_completed] != "")
      # binding.pry
      @landmark = Landmark.create(name: params[:landmark][:name], figure_id: @figure.id, year_completed: params[:landmark][:year_completed].to_i)
    end

    erb :"/figures/show"
  end

end
