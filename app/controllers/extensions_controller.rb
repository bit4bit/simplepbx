class ExtensionsController < ApplicationController
  before_action :set_extension, only: [:show, :edit, :update, :destroy]

  # GET /extensions
  # GET /extensions.json
  def index
    authorize! :read, :extensions
    @extensions = Extension.page(params[:page]).all
  end

  # GET /extensions/1
  # GET /extensions/1.json
  def show
    authorize! :read, :extensions
  end

  # GET /extensions/new
  def new
    authorize! :create, :extensions
    @extension = Extension.new
  end

  # GET /extensions/1/edit
  def edit
    authorize! :update, :extensions
  end

  # POST /extensions
  # POST /extensions.json
  def create
    authorize! :create, :extensions
    @extension = Extension.new(extension_params)

    respond_to do |format|
      if @extension.save
        format.html { redirect_to @extension, notice: 'Extension was successfully created.' }
        format.json { render :show, status: :created, location: @extension }
      else
        format.html { render :new }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extensions/1
  # PATCH/PUT /extensions/1.json
  def update
    authorize! :update, :extensions
    respond_to do |format|
      if @extension.update(extension_params)  
        begin
          @extension.expire_freeswitch_cache_user
        rescue Exception => e
          flash[:error] = "Please check your freeswitch connection"
        end
        format.html { redirect_to @extension, notice: 'Extension was successfully updated.' }
        format.json { render :show, status: :ok, location: @extension }
      else
        format.html { render :edit }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extensions/1
  # DELETE /extensions/1.json
  def destroy
    authorize! :delete, :extensions
    @extension.destroy
    begin
      @extension.expire_freeswitch_cache_user
    rescue Exception => e
      flash[:error] = "Please check your freeswitch connection"
    end
    respond_to do |format|
      format.html { redirect_to extensions_url, notice: 'Extension was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extension
      @extension = Extension.from_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_params
      params.require(:extension).permit(:endpoint_id, :username, :password, :vmpassword, :cid_name, :cid_number, :location, :extension_profile_id, :do_record)
    end
end
