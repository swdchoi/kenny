class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  def analysis
      # Time ranges
      @current_month = Time.current.beginning_of_month..Time.current.end_of_month
      @next_3_months = Time.current..(Time.current + 3.months)

      # =========================
      # KPIs (SUM payment_terms.amount)
      # =========================

      @issued_total = Invoice
        .issued
        .joins(:payment_term)
        .where(issue_date: @current_month)
        .sum("payment_terms.amount")

      @paid_total = Invoice
        .paid
        .joins(:payment_term)
        .where(paid_date: @current_month)
        .sum("payment_terms.amount")

      @outstanding_total = Invoice
        .where(status: [ :issued, :overdue ])
        .joins(:payment_term)
        .sum("payment_terms.amount")

      @overdue_total = Invoice
        .overdue
        .joins(:payment_term)
        .sum("payment_terms.amount")

      # =========================
      # Upcoming invoices
      # =========================

      @upcoming_invoices = Invoice
        .issued
        .where(due_date: @next_3_months)
        .includes(payment_term: :contract)
        .order(:due_date)

      # =========================
      # Chart: invoices issued over time
      # =========================

      @monthly_stats = Invoice
        .issued
        .joins(:payment_term)
        .where(issue_date: 6.months.ago.beginning_of_month..Time.current)
        .group_by_month(:issue_date)
        .sum("payment_terms.amount")
  end
  # GET /invoices or /invoices.json
  def index
    @payment_term = PaymentTerm.find(params[:payment_term_id])
    @invoices = @payment_term.invoice
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @payment_term = PaymentTerm.find(params[:payment_term_id])
    @invoice = @payment_term.build_invoice
    @invoice.status = 0
    @invoice.issue_date = Date.today
    @invoice.due_date = Date.today + 30
    @invoice.save
    @payment_term.invoiced!
    redirect_to contract_path(@invoice.payment_term.contract)
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @payment_term = PaymentTerm.find(params[:payment_term_id])
    @invoice = @payment_term.build_invoice(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: "Invoice was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_back(fallback_location: request.referer, notice: "Invoice was successfully destroyed.", status: :see_other) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.expect(invoice: [ :contract_id_id, :payment_term_id_id, :status, :issue_date, :due_date, :paid_date ])
    end
end
