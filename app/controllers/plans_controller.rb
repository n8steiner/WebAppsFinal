class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.where(user_id: current_user.id)
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plans = Plan.where(user_id: current_user.id)
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    @plan.major_id = Major.all[0].id
    @plan.year = Catalog.all[0].year
    @plan.current_semester = "Fall"
    @plan.current_year = @plan.year

    respond_to do |format|
      if @plan.save
        format.html { redirect_to "/", notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end

    @planCourse = PlanCourse.new()
    @planCourse.plan_id = @plan.id
    @planCourse.course_id = Course.where(identifier: "BTGE-1720")[0].id
    @planCourse.year = @plan.year
    @planCourse.term = "Fall"
    @planCourse.save!

  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
      @catalog = Catalog.where(year: @plan.year)[0]
      @major = Major.where(id: @plan.major_id)[0]
      @requirement = Requirement.where(major_id: @major.id, catalog_id: @catalog.id)[0]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:name, user_session)
    end
end
