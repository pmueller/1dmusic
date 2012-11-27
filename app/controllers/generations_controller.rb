class GenerationsController < ApplicationController
  # GET /generations
  # GET /generations.json
  def index
    @generations = Generation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generations }
    end
  end

  # GET /generations/1
  # GET /generations/1.json
  def show
    @generation = Generation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generation }
    end
  end

  # GET /generations/new
  # GET /generations/new.json
  def new
    @generation = Generation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generation }
    end
  end

  # GET /generations/1/edit
  def edit
    @generation = Generation.find(params[:id])
  end

  # POST /generations
  # POST /generations.json
  def create
    @generation = Generation.new(params[:generation])

    respond_to do |format|
      if @generation.save
        format.html { redirect_to @generation, notice: 'Generation was successfully created.' }
        format.json { render json: @generation, status: :created, location: @generation }
      else
        format.html { render action: "new" }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /generations/1
  # PUT /generations/1.json
  def update
    @generation = Generation.find(params[:id])

    respond_to do |format|
      if @generation.update_attributes(params[:generation])
        format.html { redirect_to @generation, notice: 'Generation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generations/1
  # DELETE /generations/1.json
  def destroy
    @generation = Generation.find(params[:id])
    @generation.destroy

    respond_to do |format|
      format.html { redirect_to generations_url }
      format.json { head :no_content }
    end
  end
end
