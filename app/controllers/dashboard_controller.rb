class DashboardController < ApplicationController
  def index
  end

  def clients
    @clients = Client.all
  end

  def contracts
    @contracts = Contract.all
  end

  def paymentterms
    @payment_terms = PaymentTerm.all
  end

  def milestones
    @milestones = Milestone.all
  end

  def invoice
  @invoices = Invoice.all
  end
end
