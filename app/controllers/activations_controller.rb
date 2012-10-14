class ActivationsController < ApplicationController
  # GET /activations
  # GET /activations.json
  def index
    @activations = current_user.activations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activations }
    end
  end

  # GET /activations/1
  # GET /activations/1.json
  def show
    @activation = current_user.activations.find(params[:id])
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activation }
    end
  end

  # GET /activations/new
  # GET /activations/new.json
  def new
    @activation = current_user.activations.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activation }
    end
  end

  # GET /activations/1/edit
  def edit
    @activation = current_user.activations.find(params[:id])
  end

  # POST /activations
  # POST /activations.json
  def create
    @activation = current_user.activations.build(params[:activation])

    respond_to do |format|
      if @activation.save
        format.html { redirect_to @activation, notice: 'Activation was successfully created.' }
        format.json { render json: @activation, status: :created, location: @activation }
      else
        format.html { render action: "new" }
        format.json { render json: @activation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activations/1
  # PUT /activations/1.json
  def update
    @activation = Activation.find(params[:id])

    respond_to do |format|
      if @activation.update_attributes(params[:activation])
        format.html { redirect_to @activation, notice: 'Activation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activations/1
  # DELETE /activations/1.json
  def destroy
    @activation = Activation.find(params[:id])
    @activation.destroy

    respond_to do |format|
      format.html { redirect_to activations_url }
      format.json { head :no_content }
    end
  end
end
