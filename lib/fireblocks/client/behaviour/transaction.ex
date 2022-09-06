defmodule Fireblocks.Client.Behaviour.Transaction do
  @moduledoc false

  alias Fireblocks.Input.{CreateTransaction, EstimateTxFee}
  alias Fireblocks.Response.{AddressStatus, EstimatedTxFee, TransactionDetails}

  @type error() :: {:error, Error.t()}

  ## TRANSACTION MANAGEMENT ##
  @callback create(CreateTransaction.t()) :: {:ok, %{id: String.t(), status: String.t()}} | error()

  @callback retrieve_by_fireblocks_id(tx_id :: binary()) ::
              {:ok, TransactionDetails.t()} | error()

  @callback retrieve_by_tx_id(tx_id :: binary()) ::
              {:ok, TransactionDetails.t()} | error()

  @callback cancel(tx_id :: binary()) :: {:ok, map()} | error()

  # for ETH
  @callback drop(tx_id :: binary(), fee_level :: binary()) ::
              {:ok, map()} | error()

  @callback freeze(tx_id :: binary()) :: {:ok, map()} | error()

  @callback unfreeze(tx_id :: binary()) :: {:ok, map()} | error()

  @callback estimated_tx_fee(input :: EstimateTxFee.t()) ::
              {:ok, EstimatedTxFee.t()} | error()

  # valid for XLM, XRP, DOT, EOS
  @callback validate_destination_address(asset_id :: binary(), address :: binary()) ::
              {:ok, AddressStatus.t()} | error()

  @callback set_confirmation_threshold(
              tx_id :: binary(),
              no_of_confirmations :: pos_integer()
            ) :: {:ok, map()} | error()
end
