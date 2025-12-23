class PaymentTermsController < ApplicationController
  before_action :set_payment_term, only: %i[ show edit update destroy ]

  # GET /payment_terms or /payment_terms.json
  def index
    @contract = Contract.find(params[:contract_id])
    @payment_terms = @contract.payment_terms.all
  end

  # GET /payment_terms/1 or /payment_terms/1.json
  def show
  end

  # GET /payment_terms/new
  def new
    @contract = Contract.find(params[:contract_id])
    @payment_term = @contract.payment_terms.build
  end

  # GET /payment_terms/1/edit
  def edit
    @contract = Contract.find(params[:contract_id])
  end

  # POST /payment_terms or /payment_terms.json
  def create
    @contract = Contract.find(params[:contract_id])
    @payment_term = @contract.payment_terms.build(payment_term_params)

    respond_to do |format|
      if @payment_term.save
        format.html { redirect_to @payment_term, notice: "Payment term was successfully created." }
        format.json { render :show, status: :created, location: @payment_term }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_terms/1 or /payment_terms/1.json
  def update
    respond_to do |format|
      if @payment_term.update(payment_term_params)
        format.html { redirect_to @payment_term, notice: "Payment term was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @payment_term }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_terms/1 or /payment_terms/1.json
  def destroy
    @payment_term.destroy!

    respond_to do |format|
      format.html { redirect_to payment_terms_path, notice: "Payment term was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_term
      @payment_term = PaymentTerm.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def payment_term_params
      params.expect(payment_term: [ :contract_id_id, :description, :percentage, :amount, :target_date, :status, :completed_date ])
    end
end
