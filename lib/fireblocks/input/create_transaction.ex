defmodule Fireblocks.Input.CreateTransaction do
  @moduledoc false

  @derive Jason.Encoder

  @type t :: %{
          required(:source_id) => binary(),
          required(:asset_id) => binary(),
          required(:address) => binary(),
          required(:amount) => binary(),
          required(:treat_as_gross_amount) => boolean(),
          optional(:fee_per_byte) => binary(),
          optional(:gas_price) => binary(),
          optional(:gas_limit) => binary(),
          optional(:network_fee) => binary(),
          optional(:priority_fee) => binary(),
          optional(:fee_level) => binary(),
          optional(:max_fee) => binary(),
          optional(:note) => binary(),
          optional(:transaction_id) => binary(),
          optional(:customer_ref_id) => binary()
        }

  @fields ~w[source_id asset_id address amount treat_as_gross_amount]a
  @enforce_keys @fields

  defstruct @fields

  def new(source_id, asset_id, destination_address, amount, opts \\ []) do
    attrs = %{
      source_id: source_id,
      asset_id: asset_id,
      address: destination_address,
      amount: amount,
      treat_as_gross_amount: true
    }

    optional = %{
      fee_per_byte: opts[:fee_per_byte],
      gas_price: opts[:gas_price],
      gas_limit: opts[:gas_limits],
      network_fee: opts[:network_fee],
      priority_fee: opts[:priority_fee],
      fee_level: opts[:fee_level],
      max_fee: opts[:max_fee],
      note: opts[:note],
      transaction_id: opts[:transaction_id],
      customer_ref_id: opts[:business_id]
    }

    Map.merge(struct!(__MODULE__, attrs), optional)
  end
end
