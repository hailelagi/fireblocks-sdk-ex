defmodule Fireblocks do
  @moduledoc """
    Fireblocks public interface
  """

  alias Fireblocks.Error

  alias Fireblocks.Input.{
    CreateTransaction,
    CreateVaultAsset,
    EstimateTxFee,
    GenerateVaultAccountDepositAddress
  }

  alias Fireblocks.Response.{
    AddressStatus,
    CreateVaultAssetResponse,
    EstimatedTxFee,
    SupportedAsset,
    TransactionDetails,
    UnspentInputs,
    VaultAccount,
    VaultAccountDepositAddress,
    VaultAsset
  }

  @type error() :: {:error, Error.t()}

  @spec supported_assets() :: {:ok, list(SupportedAsset.t())} | error()
  def supported_assets do
    case impl().supported_assets() do
      {:ok, data} -> {:ok, Enum.map(data, fn asset -> SupportedAsset.new(asset) end)}
      err -> err
    end
  end

  ## VAULT MANAGEMENT
  def create_vault_account(business_name, business_id) do
    body = %{name: business_name, customer_ref_id: business_id}

    case vault().create_account(body) do
      {:ok, data} -> {:ok, VaultAccount.new(data)}
      err -> err
    end
  end

  def retrieve_vault_account(id) do
    case vault().retrieve_account(id) do
      {:ok, data} -> {:ok, VaultAccount.new(data)}
      err -> err
    end
  end

  @doc """
    note: asset name should be in opts to the command that provides input.
    if it's EOS, the account name will be "EOS <> _ <> vault_id"
  """
  def create_asset_wallet_for_vault_account(
        %CreateVaultAsset{vault_account_id: _vault_account_id, asset_id: _asset_id} = input
      ) do
    case vault().create_asset_wallet_for_account(input) do
      {:ok, data} -> {:ok, CreateVaultAssetResponse.new(data)}
      err -> err
    end
  end

  def fetch_vault_account_wallet_balance(vault_account_id, asset_id) do
    case vault().fetch_account_wallet_balance(vault_account_id, asset_id) do
      {:ok, data} -> {:ok, VaultAsset.new(data)}
      err -> err
    end
  end

  def refresh_vault_account_wallet_balance(vault_account_id, asset_id) do
    case vault().refresh_account_wallet_balance(vault_account_id, asset_id) do
      {:ok, data} -> {:ok, VaultAsset.new(data)}
      err -> err
    end
  end

  def generate_deposit_address_for_asset(
        %GenerateVaultAccountDepositAddress{
          vault_account_id: _vault_account_id,
          asset_id: asset_id,
          description: description,
          customer_ref_id: _business_id
        } = input
      ) do
    body = %{
      description: input.description,
      customerRefId: input.customer_ref_id
    }

    case vault().generate_deposit_address_for_asset(body) do
      {:ok, data} -> {:ok, VaultAccountDepositAddress.new(data, asset_id, description)}
      err -> err
    end
  end

  def retrieve_vault_account_wallet_deposit_addresses(vault_account_id, asset_id) do
    case vault().retrieve_account_wallet_deposit_addresses(vault_account_id, asset_id) do
      {:ok, data} -> {:ok, VaultAccountDepositAddress.new(data)}
      err -> err
    end
  end

  def retrieve_unspent_inputs(vault_account_id, asset_id) do
    case vault().retrieve_unspent_inputs(vault_account_id, asset_id) do
      {:ok, data} -> {:ok, UnspentInputs.new(data)}
      err -> err
    end
  end

  ## TRANSACTION MANAGEMENT
  ## Transfering out of Fireblocks and Transaction statuses ##

  @doc """
    This API call is subject to rate limits, if rate limited will return
    {:error, :rate_limited}
  """

  def create_transaction(%CreateTransaction{} = opts) do
    body =
      %{
        assetId: opts[:asset_id],
        source: %{
          type: "VAULT_ACCOUNT",
          id: opts[:source_id]
        },
        destination: %{
          type: "ONE_TIME_ADDRESS",
          oneTimeAddress: opts[:address]
        },
        amount: opts[:amount],
        treatAsGrossAmount: false,
        fee: opts[:fee_per_byte],
        gasPrice: opts[:gas_price],
        gasLimit: opts[:gas_limit],
        networkFee: opts[:network_fee],
        priorityFee: opts[:priority_fee],
        feeLevel: opts[:fee_level],
        maxFee: opts[:max_fee],
        note: opts[:note],
        customerRefId: opts[:customer_ref_id],
        externalTxId: opts[:transaction_id]
      }

    case transaction().create(body) do
      {:ok, data} -> {:ok, data}
      err -> err
    end
  end

  def retrieve_transaction_by_fireblocks_id(fireblocks_tx_id) do
    case transaction().retrieve_by_fireblocks_id(fireblocks_tx_id) do
      {:ok, data} -> {:ok, TransactionDetails.new(data)}
      err -> err
    end
  end

  def retrieve_transaction_by_tx_id(tx_id) do
    case transaction().retrieve_by_tx_id(tx_id) do
      {:ok, data} -> {:ok, TransactionDetails.new(data)}
      err -> err
    end
  end

  def cancel_transaction(fireblocks_tx_id) do
    case transaction().cancel(fireblocks_tx_id) do
      {:ok, %{"success" => true} = data} -> {:ok, data}
      {:ok, _} -> {:error, "transaction() couldn't be cancelled"}
      err -> err
    end
  end

  def drop_transaction(fireblocks_tx_id, fee_level) do
    case transaction().drop(fireblocks_tx_id, fee_level) do
      {:ok, %{"success" => true} = data} -> {:ok, data}
      {:ok, _} -> {:error, "transaction() couldn't be dropped"}
      err -> err
    end
  end

  def freeze_transaction(fireblocks_tx_id) do
    case transaction().freeze(fireblocks_tx_id) do
      {:ok, %{"success" => true} = data} -> {:ok, data}
      {:ok, _} -> {:error, "transaction() couldn't be frozen"}
      err -> err
    end
  end

  def unfreeze_transaction(fireblocks_tx_id) do
    case transaction().unfreeze(fireblocks_tx_id) do
      {:ok, %{"success" => true} = data} -> {:ok, data}
      {:ok, _} -> {:error, "transaction() couldn't be unfrozen"}
      err -> err
    end
  end

  def estimated_tx_fee(%EstimateTxFee{} = input) do
    body = %{
      source: %{
        type: "VAULT_ACCOUNT",
        id: input[:vault_account_id]
      },
      destination: %{
        type: "ONE_TIME_ADDRESS",
        oneTimeAddress: input[:address]
      },
      amount: input[:amount],
      assetId: input[:asset_id]
    }

    case transaction().estimated_tx_fee(body) do
      {:ok, data} -> {:ok, EstimatedTxFee.new(data)}
      err -> err
    end
  end

  @doc """
    Supported for the following assets: XRP, DOT, XLM, EOS.
  """
  def validate_destination_address(asset_id, address) do
    case transaction().validate_destination_address(asset_id, address) do
      {:ok, data} -> {:ok, AddressStatus.new(data)}
      err -> err
    end
  end

  def set_confirmation_threshold(fireblocks_tx_id, no_of_confirmations) do
    body = %{numOfConfirmations: no_of_confirmations}

    case transaction().set_confirmation_threshold(fireblocks_tx_id, body) do
      {:ok, data} -> {:ok, data}
      err -> err
    end
  end

  defp impl, do: Application.get_env(:fireblocks, :client, Fireblocks.Client)
  defp transaction, do: Application.get_env(:fireblocks, :client, Fireblocks.Client.Transaction)
  defp vault, do: Application.get_env(:fireblocks, :client, Fireblocks.Client.Vault)
end
