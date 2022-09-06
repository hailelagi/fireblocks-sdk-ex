alias Fireblocks.Client.Behaviour.{Transaction, Vault}

Mox.defmock(Fireblocks.ClientMock, for: [Fireblocks.Client.Behaviour, Transaction, Vault])
Application.put_env(:fireblocks, :client, Fireblocks.ClientMock)

ExUnit.start()
