defmodule Fireblocks.Client.Behaviour.Vault do
  @moduledoc false

  alias Fireblocks.Error

  alias Fireblocks.Input.{CreateVaultAsset, GenerateVaultAccountDepositAddress}

  alias Fireblocks.Response.{
    CreateVaultAssetResponse,
    UnspentInputs,
    VaultAccount,
    VaultAccountDepositAddress,
    VaultAsset
  }

  @type error() :: {:error, Error.t()}

  ## VAULT MANAGEMENT ##
  @callback create_account(input: map()) ::
              {:ok, VaultAccount.t()} | error()

  @callback retrieve_account(vault_account_id :: binary()) ::
              {:ok, VaultAccount.t()} | error()

  @callback create_asset_wallet_for_account(CreateVaultAsset.t()) ::
              {:ok, CreateVaultAssetResponse.t()} | error()

  @callback fetch_account_wallet_balance(vault_account_id :: binary(), asset_id :: binary()) ::
              {:ok, VaultAsset.t()} | error()

  @callback refresh_account_wallet_balance(
              vault_account_id :: binary(),
              asset_id :: binary()
            ) ::
              {:ok, VaultAsset.t()} | error()

  @callback generate_deposit_address_for_asset(GenerateVaultAccountDepositAddress.t()) ::
              {:ok, VaultAccountDepositAddress.t()} | error()

  # todo
  @callback retrieve_account_wallet_deposit_addresses(
              vault_account_id :: binary(),
              asset_id :: binary()
            ) :: nil

  @callback retrieve_unspent_inputs(vault_account_id :: binary(), asset_id :: binary()) ::
              {:ok, UnspentInputs.t()} | error()
end
