# Makefile to automate deployment on Anvil

# Set environment variables
PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
RPC_URL=http://127.0.0.1:8545
SCRIPT_PATH=script/deploycontracts.s.sol

# Default target
all: start-anvil deploy

# Start Anvil (local Ethereum testnet)
start-anvil:
	@echo "Starting Anvil..."
	anvil &
	@sleep 3 # Give it a few seconds to start

# Deploy contracts using Foundry
deploy:
	@echo "Deploying contracts..."
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast

# Stop Anvil (if needed)
stop-anvil:
	@echo "Stopping Anvil..."
	pkill -f anvil || true

# Clean up (optional)
clean:
	@echo "Cleaning up cached artifacts..."
	forge clean
