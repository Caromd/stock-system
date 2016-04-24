class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :get_items, only: [:new, :create, :edit]
  before_action :authenticate_user!, only: [:new]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    10.times do
      @line = @document.lines.build
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = current_user.documents.new(document_params)
    10.times do
      @line = @document.lines.build
    end
    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_url, notice: 'Document was successfully created.' }
        format.json { render :index, status: :created, location: documents_url }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to documents_url, notice: 'Document was successfully updated.' }
        format.json { render :index, status: :ok, location: documents_url }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end
    
    def get_items
      @items = Item.order("code asc")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(
        :code, :docdate, :comment, :user_id, :location_id,
        lines_attributes: [:id, :qtynew, :qtyused, :comment, :document_id, :item_id])
    end
end
