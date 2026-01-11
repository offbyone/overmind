# Build a local development version
build:
    go build -ldflags "-X main.version=dev" -o overmind .

# Run tests
test:
    go test -v ./...

# Run linter
lint:
    golangci-lint run --timeout 5m0s

# Build a snapshot release (useful for testing)
snapshot:
    goreleaser release --snapshot --clean

# Check if the goreleaser config is valid
check-config:
    goreleaser check

# Clean build artifacts
clean:
    rm -rf ./dist
    rm -f overmind

# Show current version from git tags
version:
    @git describe --always --tags --abbrev=0 2>/dev/null || echo "no tags found"

# Install goreleaser (if not already installed)
install-goreleaser:
    @which goreleaser > /dev/null || (echo "Installing goreleaser..." && go install github.com/goreleaser/goreleaser/v2@latest)

# Local release (requires goreleaser to be installed)
release: install-goreleaser
    goreleaser release --clean
