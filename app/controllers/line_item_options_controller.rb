class LineItemOptionsController < ApplicationController
  # GET /line_item_options
  # GET /line_item_options.json
  def index
    @line_item_options = LineItemOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_item_options }
    end
  end

  # GET /line_item_options/1
  # GET /line_item_options/1.json
  def show
    @line_item_option = LineItemOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item_option }
    end
  end

  # GET /line_item_options/new
  # GET /line_item_options/new.json
  def new
    @line_item_option = LineItemOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item_option }
    end
  end

  # GET /line_item_options/1/edit
  def edit
    @line_item_option = LineItemOption.find(params[:id])
  end

  # POST /line_item_options
  # POST /line_item_options.json
  def create
    @line_item_option = LineItemOption.new(params[:line_item_option])

    respond_to do |format|
      if @line_item_option.save
        format.html { redirect_to @line_item_option, notice: 'Line item option was successfully created.' }
        format.json { render json: @line_item_option, status: :created, location: @line_item_option }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_item_options/1
  # PUT /line_item_options/1.json
  def update
    @line_item_option = LineItemOption.find(params[:id])

    respond_to do |format|
      if @line_item_option.update_attributes(params[:line_item_option])
        format.html { redirect_to @line_item_option, notice: 'Line item option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_item_options/1
  # DELETE /line_item_options/1.json
  def destroy
    @line_item_option = LineItemOption.find(params[:id])
    @line_item_option.destroy

    respond_to do |format|
      format.html { redirect_to line_item_options_url }
      format.json { head :no_content }
    end
  end
end
