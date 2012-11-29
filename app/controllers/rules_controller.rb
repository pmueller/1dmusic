class RulesController < ApplicationController
  load_and_authorize_resource :song
  load_and_authorize_resource :rule, through: :song

  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rules }
    end
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
    @rule = Rule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.json
  def new
    @rule = Rule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = Rule.find(params[:id])
  end

  # POST /rules
  # POST /rules.json
  def create
    @song = Song.find(params[:song_id])
    @rule = @song.rules.new(params[:rule])

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'Rule was successfully created.' }
        format.json { render json: @rule, status: :created, location: @rule }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.json
  def update
    @song = Song.find(params[:song_id])
    @rule = @song.rules.find(params[:id])

      if params[:rule][:neighborhood_size].present?
        @rule.update_neighborhood_size(params[:rule][:neighborhood_size].to_i)
      else
        @rule.update_attributes(params[:rule])
      end

    respond_to do |format|
      format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
      format.json { head :no_content }
      format.js
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @song = Song.find(params[:song_id])
    @rule = @song.rules.find(params[:id])
    @rule.destroy
    @destroyed_id = params[:id]

    respond_to do |format|
      format.html { redirect_to rules_url }
      format.json { head :no_content }
      format.js
    end
  end
end
