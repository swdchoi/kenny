class MilestonesController < ApplicationController
  before_action :set_milestone, only: %i[ show edit update destroy ]

  # GET /milestones or /milestones.json
  def index
    @contract = Contract.find(params[:contract_id])
    @milestones = @contract.milestones.all
  end

  # GET /milestones/1 or /milestones/1.json
  def show
  end

  # GET /milestones/new
  def new
    @contract = Contract.find(params[:contract_id])
    @milestone = @contract.milestones.build
  end

  # GET /milestones/1/edit
  def edit
  end

  # POST /milestones or /milestones.json
  def create
    @contract = Contract.find(params[:contract_id])
    @milestone = @contract.milestones.build(milestone_params)

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to @milestone, notice: "Milestone was successfully created." }
        format.json { render :show, status: :created, location: @milestone }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /milestones/1 or /milestones/1.json
  def update
    respond_to do |format|
      if @milestone.update(milestone_params)
        format.html { redirect_to @milestone, notice: "Milestone was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @milestone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milestones/1 or /milestones/1.json
  def destroy
    @milestone.destroy!

    respond_to do |format|
      format.html { redirect_to milestones_path, notice: "Milestone was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_milestone
      @milestone = Milestone.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def milestone_params
      params.expect(milestone: [ :name, :date, :status, :contract_id_id ])
    end
end
