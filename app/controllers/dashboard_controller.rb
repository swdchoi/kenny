class DashboardController < ApplicationController
def index
  @start_date = params[:start_date]
  @end_date = params[:end_date]
  # Top-level counts
  @client_count   = Client.count
  @contract_count = Contract.active.count

  # Invoices
  @invoices_issued      = Invoice.issued.order(due_date: :desc)
  @invoices_collected   = Invoice.collected.order(due_date: :desc)
  @invoices_outstanding = Invoice.outstanding.order(due_date: :asc)
  @invoices_late        = Invoice.late.order(due_date: :asc)

  # Money
  @money_issued = PaymentTerm
    .joins(:invoice)
    .merge(Invoice.issued)
    .sum(:amount)

  @money_collected = PaymentTerm
    .joins(:invoice)
    .merge(Invoice.collected)
    .sum(:amount)

  @money_outstanding = PaymentTerm
    .joins(:invoice)
    .merge(Invoice.outstanding)
    .sum(:amount)

  # Delivery & finance actions
  @milestones_upcoming      = Milestone.upcoming.order(date: :asc)
  @milestones_overdue       = Milestone.overdue.order(date: :asc)

  @payment_terms_upcoming   = PaymentTerm.upcoming.order(target_date: :asc)
  @payment_terms_need_issue = PaymentTerm.need_issue.order(target_date: :asc)
  @payment_terms_overdue    = PaymentTerm.overdue.order(target_date: :asc)
end

  def clients
    @clients = Client.all
  end

  def contracts
    @contracts = Contract.all
  end

  def paymentterms
    @payment_terms_upcoming   = PaymentTerm.upcoming.order(target_date: :asc)
    @payment_terms_need_issue = PaymentTerm.need_issue.order(target_date: :asc)
    @payment_terms_overdue    = PaymentTerm.overdue.order(target_date: :asc)
    @payment_terms_invoiced   = PaymentTerm.invoiced.order(target_date: :desc)
    @payment_terms_done       = PaymentTerm.done.order(target_date: :desc)
  end

  def milestones
      @milestones_upcoming = Milestone.upcoming.order(date: :asc)
      @milestones_overdue  = Milestone.overdue.order(date: :asc)
      @milestones_finished = Milestone.finished.order(date: :desc)
  end

  def invoice
  # Invoices
  @invoices_issued = Invoice
  .where.not(issue_date: nil)
  .where(paid_date: nil)
  .order(due_date: :desc)

  @invoices_collected   = Invoice.collected.order(due_date: :desc)
  @invoices_outstanding = Invoice.outstanding.order(due_date: :asc)
  @invoices_late        = Invoice.late.order(due_date: :asc)

  # Money
  @money_issued = PaymentTerm
    .joins(:invoice)
    .merge(Invoice.issued)
    .sum(:amount)

  @money_collected = PaymentTerm
    .joins(:invoice)
    .merge(Invoice.collected)
    .sum(:amount)

  @money_outstanding = PaymentTerm
    .joins(:invoice)
    .merge(Invoice.outstanding)
    .sum(:amount)
  end
end
