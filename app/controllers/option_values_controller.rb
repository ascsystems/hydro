class OptionValuesController < ApplicationController
  # GET /option_values
  # GET /option_values.json
  def index
    @option_values = OptionValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @option_values }
    end
  end

  # GET /option_values/1
  # GET /option_values/1.json
  def show
    @option_value = OptionValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @option_value }
    end
  end

  # GET /option_values/new
  # GET /option_values/new.json
  def new
    @option_value = OptionValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @option_value }
    end
  end

  # GET /option_values/1/edit
  def edit
    @option_value = OptionValue.find(params[:id])
  end

  # POST /option_values
  # POST /option_values.json
  def create
    @option_value = OptionValue.new(params[:option_value])

    respond_to do |format|
      if @option_value.save
        format.html { redirect_to @option_value, notice: 'Option value was successfully created.' }
        format.json { render json: @option_value, status: :created, location: @option_value }
      else
        format.html { render action: "new" }
        format.json { render json: @option_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /option_values/1
  # PUT /option_values/1.json
  def update
    @option_value = OptionValue.find(params[:id])

    respond_to do |format|
      if @option_value.update_attributes(params[:option_value])
        format.html { redirect_to @option_value, notice: 'Option value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @option_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /option_values/1
  # DELETE /option_values/1.json
  def destroy
    @option_value = OptionValue.find(params[:id])
    @option_value.destroy

    respond_to do |format|
      format.html { redirect_to option_values_url }
      format.json { head :no_content }
    end
  end
end
