class ProductOptionValuesController < ApplicationController
  # GET /product_option_values
  # GET /product_option_values.json
  def index
    @product_option_values = ProductOptionValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_option_values }
    end
  end

  # GET /product_option_values/1
  # GET /product_option_values/1.json
  def show
    @product_option_value = ProductOptionValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_option_value }
    end
  end

  # GET /product_option_values/new
  # GET /product_option_values/new.json
  def new
    @product_option_value = ProductOptionValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_option_value }
    end
  end

  # GET /product_option_values/1/edit
  def edit
    @product_option_value = ProductOptionValue.find(params[:id])
  end

  # POST /product_option_values
  # POST /product_option_values.json
  def create
    @product_option_value = ProductOptionValue.new(params[:product_option_value])

    respond_to do |format|
      if @product_option_value.save
        format.html { redirect_to @product_option_value, notice: 'Product option value was successfully created.' }
        format.json { render json: @product_option_value, status: :created, location: @product_option_value }
      else
        format.html { render action: "new" }
        format.json { render json: @product_option_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_option_values/1
  # PUT /product_option_values/1.json
  def update
    @product_option_value = ProductOptionValue.find(params[:id])

    respond_to do |format|
      if @product_option_value.update_attributes(params[:product_option_value])
        format.html { redirect_to @product_option_value, notice: 'Product option value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_option_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_option_values/1
  # DELETE /product_option_values/1.json
  def destroy
    @product_option_value = ProductOptionValue.find(params[:id])
    @product_option_value.destroy

    respond_to do |format|
      format.html { redirect_to product_option_values_url }
      format.json { head :no_content }
    end
  end
end
