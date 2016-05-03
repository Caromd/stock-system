class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy, :export, :history]
  before_action :item_summary, only: [:show, :export]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    respond_to do |format|
      format.html
      format.csv { send_data @locations.to_csv, filename: "Locations-#{Date.today}.csv" }
    end    
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end
  
  def history
    @history = Location.find_by_sql(
      ["SELECT d.code code, l.qtynew, l.qtyused, (IFNULL(l.qtynew,0) + IFNULL(l.qtyused,0)) total
      FROM documents d
      JOIN lines l ON l.document_id = d.id
      JOIN items i on i.id = l.item_id
      WHERE d.location_id = ?
      AND i.code = ?", params[:id], params[:item_code]])
    @totals = Location.find_by_sql(
      ["SELECT sum(l.qtynew) qtynew, sum(l.qtyused) qtyused, sum(IFNULL(l.qtynew,0) + IFNULL(l.qtyused,0)) total
      FROM documents d
      JOIN lines l ON l.document_id = d.id
      JOIN items i on i.id = l.item_id
      WHERE d.location_id = ?
      AND i.code = ?", params[:id], params[:item_code]])   
    @item = Item.find_by_code(params[:item_code])
  end
  
  def export
    respond_to do |format|
      format.html { redirect_to root_url }
      format.csv do
        headers['Content-Disposition'] = "attachment; filename='Item-Quantities-#{@location.name}-#{Date.today}.csv'"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_url, notice: 'Location was successfully created.' }
        format.json { render :index, status: :created, location: locations_url }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to locations_url, notice: 'Location was successfully updated.' }
        format.json { render :index, status: :ok, location: locations_url }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      message = "Location destroyed successfully"
    else
      message = "Location could not be destroyed"
    end


    respond_to do |format|
      format.html { redirect_to locations_url, :notice => message }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name)
    end

    def item_summary
      @items = Location.find_by_sql(
      ["SELECT i.code code, i.description description, sum(l.qtynew) qtynew, sum(l.qtyused) qtyused, sum(IFNULL(l.qtynew,0) + IFNULL(l.qtyused,0)) total
      FROM documents d
      JOIN lines l ON l.document_id = d.id
      JOIN items i on i.id = l.item_id
      WHERE d.location_id = ?
      GROUP BY i.code, i.description", params[:id]])
    end
end