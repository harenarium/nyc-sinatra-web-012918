class FiguresController < ApplicationController

  get '/figures/new' do
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        FigureTitle.create(title_id: title_id, figure_id: @figure.id)
      end
    else
      @title = Title.create(params[:title])
      @figure_title = FigureTitle.create(title_id: @title.id, figure_id: @figure.id)
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        @landmark = Landmark.find_by_id(landmark_id)
        @landmark.figure_id = @figure.id
      end
    else
      @landmark = Landmark.create(name: params[:landmark][:name], figure_id: @figure.id, year_completed: params[:landmark][:year_completed].to_i)
    end

    redirect "/figures"
  end

  get '/figures' do
    erb :"/figures/show_all"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/show"
  end

  get 'figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/edit"
  end

  # patch 'figures/:id/edit' do
  #
  # end
end
