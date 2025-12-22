require "test_helper"

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_contract_url
    assert_response :success
  end

  test "should create contract" do
    assert_difference("Contract.count") do
      post contracts_url, params: { contract: { client_id_id: @contract.client_id_id, description: @contract.description, end_date: @contract.end_date, start_date: @contract.start_date, title: @contract.title, total_amount: @contract.total_amount } }
    end

    assert_redirected_to contract_url(Contract.last)
  end

  test "should show contract" do
    get contract_url(@contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_contract_url(@contract)
    assert_response :success
  end

  test "should update contract" do
    patch contract_url(@contract), params: { contract: { client_id_id: @contract.client_id_id, description: @contract.description, end_date: @contract.end_date, start_date: @contract.start_date, title: @contract.title, total_amount: @contract.total_amount } }
    assert_redirected_to contract_url(@contract)
  end

  test "should destroy contract" do
    assert_difference("Contract.count", -1) do
      delete contract_url(@contract)
    end

    assert_redirected_to contracts_url
  end
end
