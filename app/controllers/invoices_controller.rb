class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

def analysis
  # =========================
  # Time ranges
  # =========================
  @last_30_days = 30.days.ago.beginning_of_day..Time.current
  @today        = Date.current
  @next_30_days = @today..30.days.from_now
  @next_60_days = @today..60.days.from_now
  @next_90_days = @today..90.days.from_now

  # =========================
  # LAST 30 DAYS PERFORMANCE
  # =========================

  @issued_total = Invoice
    .where(issue_date: @last_30_days)
    .joins(:payment_term)
    .sum("payment_terms.amount")

  @collected_total = Invoice
    .where(paid_date: @last_30_days)
    .joins(:payment_term)
    .sum("payment_terms.amount")

  @outstanding_total = Invoice
    .where(issue_date: ..@today)
    .where(paid_date: nil)
    .joins(:payment_term)
    .sum("payment_terms.amount")

  @overdue_total = Invoice
    .where(issue_date: ..@today)
    .where(paid_date: nil)
    .where("due_date < ?", @today)
    .joins(:payment_term)
    .sum("payment_terms.amount")

  # =========================
  # FORWARD-LOOKING PROJECTIONS
  # =========================

  @due_next_30 = upcoming_total(@next_30_days)
  @due_next_60 = upcoming_total(@next_60_days)
  @due_next_90 = upcoming_total(@next_90_days)

  # =========================
  # UPCOMING INVOICES (TABLE)
  # =========================

  @upcoming_invoices = Invoice
    .where(paid_date: nil)
    .where(due_date: @next_90_days)
    .includes(payment_term: :contract)
    .order(:due_date)

  # =========================
  # CHART (Last 6 months)
  # =========================

  @monthly_stats = Invoice
    .where(issue_date: 6.months.ago.beginning_of_month..Time.current)
    .joins(:payment_term)
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
        format.html { redirect_to contract_path(@invoice.payment_term.contract), notice: "Invoice was successfully created." }
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
        format.html { redirect_to contract_path(@invoice.payment_term.contract), notice: "Invoice was successfully updated.", status: :see_other }
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
      format.html { redirect_to contract_path(@invoice.payment_term.contract), notice: "Invoice was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def upcoming_total(range)
  Invoice
    .where(paid_date: nil)
    .where(due_date: range)
    .joins(:payment_term)
    .sum("payment_terms.amount")
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.expect(invoice: [ :contract_id_id, :payment_term_id_id, :status, :issue_date, :due_date, :paid_date ])
    end
end
