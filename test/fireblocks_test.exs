defmodule FireblocksTest do
  @moduledoc false

  use ExUnit.Case, async: true
  import Mox

  alias Fireblocks.TestUtils

  setup(:verify_on_exit!)

  describe "Fireblocks" do
    test "gets and parses supported assets" do
      expect(Fireblocks.ClientMock, :supported_assets, fn -> {:ok, TestUtils.supported_assets()} end)

      assert {:ok, [%Fireblocks.Response.SupportedAsset{} | _]} = Fireblocks.supported_assets()
    end
  end
end
