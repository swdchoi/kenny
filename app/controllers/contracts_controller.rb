class ContractsController < ApplicationController
  before_action :set_contract, only: %i[ show edit update destroy ]

  # GET /contracts or /contracts.json
  def index
    if params[:client_id].present?
      @client = Client.find(params[:client_id])
      @contracts = @client.contracts
    end
    @contracts = Contract.all
  end

  # GET /contracts/1 or /contracts/1.json
  def show
    @milestones = @contract.milestones
    @payment_terms = @contract.payment_terms
  end

  # GET /contracts/new
  def new
    @client = Client.find(params[:client_id])
    @contract =  @client.contracts.build
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts or /contracts.json
  def create
    @client = Client.find(params[:client_id])
    @contract =  @client.contracts.build(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: "Contract was successfully created." }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1 or /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: "Contract was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1 or /contracts/1.json
  def destroy
    @client = Client.find(@contract.client.id)
    @contract.destroy!


    respond_to do |format|
      format.html { redirect_to contracts_path(@client), notice: "Contract was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.expect(contract: [ :client_id_id, :title, :description, :start_date, :end_date, :total_amount, :status ])
    end
end
