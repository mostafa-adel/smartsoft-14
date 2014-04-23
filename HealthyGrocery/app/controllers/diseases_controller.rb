class DiseasesController < ApplicationController
  # GET /diseases
  # GET /diseases.json
  def index
    @diseases = Disease.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diseases }
    end
  end

  # GET /diseases/1
  # GET /diseases/1.json
  def show
    @disease = Disease.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @disease }
    end
  end

  # GET /diseases/new
  # GET /diseases/new.json
  def new
    @disease = Disease.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disease }
    end

  end

  # GET /diseases/1/edit
  def edit
    @disease = Disease.find(params[:id])


  end

  # POST /diseases
  # POST /diseases.json
  def create
     @disease = Disease.new(params[:disease])
    
     @reco = params[:ii]
    if @reco != nil
     @disease.recommended_items << Item.find(@reco.first)
     @disease.save
     @reco.each do |p|
       
        @disease.recommended_items << Item.find(p)
        @disease.save

    end 
  end
    @rest = params[:r]
   if @rest != nil 
    @disease.restricted_items << Item.find(@rest.first)
    @disease.save
    @rest.each do |f|
      @temp = Item.find(f)
       if @disease.recommended_items.include?(@temp)
          
          #code to prevent chosing one item 4 both
          end
         
        @disease.restricted_items << Item.find(f)
        @disease.save
      end
     end
         
    
    respond_to do |format|
      if @disease.save
        format.html { redirect_to diseases_url }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  
 end 

  # PUT /diseases/1
  # PUT /diseases/1.json
  def update
    @disease = Disease.find(params[:id])
    @disease.recommended_items = []
    @disease.restricted_items = []
    @reco = params[:ii]
    if @reco != nil
     @disease.recommended_items << Item.find(@reco.first)
     @disease.save
     @reco.each do |p|
       
        @disease.recommended_items << Item.find(p)
        @disease.save

    end 
  end
  @rest = params[:r]
   if @rest != nil 
    @disease.restricted_items << Item.find(@rest.first)
    @disease.save
    @rest.each do |f|
       
        @disease.restricted_items << Item.find(f)
        @disease.save
     end
    end 
    respond_to do |format|
      if @disease.update_attributes(params[:disease])
        format.html { redirect_to diseases_url}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /diseases/1
  # DELETE /diseases/1.json
  def destroy
    @disease = Disease.find(params[:id])
    @disease.destroy

    respond_to do |format|
      format.html { redirect_to diseases_url }
      format.json { head :no_content }
    end
  end
end
