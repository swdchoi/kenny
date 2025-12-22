require "application_system_test_case"

class PaymentTermsTest < ApplicationSystemTestCase
  setup do
    @payment_term = payment_terms(:one)
  end

  test "visiting the index" do
    visit payment_terms_url
    assert_selector "h1", text: "Payment terms"
  end

  test "should create payment term" do
    visit payment_terms_url
    click_on "New payment term"

    fill_in "Amount", with: @payment_term.amount
    fill_in "Completed date", with: @payment_term.completed_date
    fill_in "Contract id", with: @payment_term.contract_id_id
    fill_in "Description", with: @payment_term.description
    fill_in "Percentage", with: @payment_term.percentage
    fill_in "Status", with: @payment_term.status
    fill_in "Target date", with: @payment_term.target_date
    click_on "Create Payment term"

    assert_text "Payment term was successfully created"
    click_on "Back"
  end

  test "should update Payment term" do
    visit payment_term_url(@payment_term)
    click_on "Edit this payment term", match: :first

    fill_in "Amount", with: @payment_term.amount
    fill_in "Completed date", with: @payment_term.completed_date
    fill_in "Contract id", with: @payment_term.contract_id_id
    fill_in "Description", with: @payment_term.description
    fill_in "Percentage", with: @payment_term.percentage
    fill_in "Status", with: @payment_term.status
    fill_in "Target date", with: @payment_term.target_date
    click_on "Update Payment term"

    assert_text "Payment term was successfully updated"
    click_on "Back"
  end

  test "should destroy Payment term" do
    visit payment_term_url(@payment_term)
    click_on "Destroy this payment term", match: :first

    assert_text "Payment term was successfully destroyed"
  end
end
