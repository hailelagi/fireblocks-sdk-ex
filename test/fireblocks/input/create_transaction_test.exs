defmodule Fireblocks.Input.CreateTransactionTest do
  @moduledoc false
  use ExUnit.Case

  alias Fireblocks.Input.CreateTransaction

  test "creating a transaction" do
    assert CreateTransaction.new("fake_source_id", "asset_id", "0xdestination_address", "50.00")
  end
end
