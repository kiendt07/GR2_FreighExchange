class Supplier::VehiclesController < Supplier::BaseController
  def index   
   	@vehicles = Vehicle.all
  end

  def show
  	@vehicle = Vehicle.find(params[:id])
  end

  def new
  	@vehicle = Vehicle.new
  end

  def edit
  	@vehicle = Vehicle.find params[:id]
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    
    respond_to do |format|
      if @vehicle.save
        format.html { flash[:success] = 'Your vehicle successfully created.'
          redirect_to supplier_vehicles_path }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vehicle = Vehicle.find params[:id]
    @vehicle.save
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to supplier_vehicles_path, notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle = Vehicle.find params[:id]
  	@vehicle.destroy
    respond_to do |format|
      format.html { flash[:danger] = 'Your vehicle successfully destroyed.' 
        redirect_to supplier_vehicles_path }
      format.json { head :no_content }
    end
  end

  def vehicle_params
      params.require(:vehicle).permit(:vehicle_number, :available, :point, :s_id, :category_id, :cost_per_km)
    end
end