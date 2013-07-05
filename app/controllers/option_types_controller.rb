class OptionTypesController < ApplicationController
  # GET /option_types
  # GET /option_types.json
  def index
    @option_types = OptionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @option_types }
    end
  end

  # GET /option_types/1
  # GET /option_types/1.json
  def show
    @option_type = OptionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @option_type }
    end
  end

  # GET /option_types/new
  # GET /option_types/new.json
  def new
    @option_type = OptionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @option_type }
    end
  end

  # GET /option_types/1/edit
  def edit
    @option_type = OptionType.find(params[:id])
  end

  # POST /option_types
  # POST /option_types.json
  def create
    @option_type = OptionType.new(params[:option_type])

    respond_to do |format|
      if @option_type.save
        format.html { redirect_to @option_type, notice: 'Option type was successfully created.' }
        format.json { render json: @option_type, status: :created, location: @option_type }
      else
        format.html { render action: "new" }
        format.json { render json: @option_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /option_types/1
  # PUT /option_types/1.json
  def update
    @option_type = OptionType.find(params[:id])

    respond_to do |format|
      if @option_type.update_attributes(params[:option_type])
        format.html { redirect_to @option_type, notice: 'Option type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @option_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /option_types/1
  # DELETE /option_types/1.json
  def destroy
    @option_type = OptionType.find(params[:id])
    @option_type.destroy

    respond_to do |format|
      format.html { redirect_to option_types_url }
      format.json { head :no_content }
    end
  end
end
