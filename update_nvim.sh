#!/usr/bin/env bash
set -euo pipefail

# ANSI color codes for better output formatting
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Temporary directory for downloads
readonly TMP_DIR="$(mktemp -d)"
readonly NVIM_TMP_FILE="${TMP_DIR}/nvim.appimage"

# Cleanup function to remove temporary files on exit
cleanup() {
	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

# Helper functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

die() {
	log_error "$1"
	exit 1
}

# Check if command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Check dependencies
check_dependencies() {
	local missing_deps=()

	for cmd in curl awk sed; do
		if ! command_exists "$cmd"; then
			missing_deps+=("$cmd")
		fi
	done

	if [[ ${#missing_deps[@]} -gt 0 ]]; then
		die "Missing dependencies: ${missing_deps[*]}. Please install them first."
	fi
}

# Get system information
get_system_info() {
	if ! command_exists uname; then
		die "The 'uname' command is not available."
	fi

	# Check architecture
	readonly ARCH=$(uname -m)
	if [[ "${ARCH}" != "x86_64" ]]; then
		log_warning "This script is optimized for x86_64 architecture. Detected: ${ARCH}"
		read -p "Continue anyway? (y/N): " -r CONTINUE
		if [[ ! "${CONTINUE}" =~ ^[Yy]$ ]]; then
			log_info "Exiting by user request."
			exit 0
		fi
	fi
}

# Find Neovim installation path
find_neovim() {
	if ! command_exists nvim; then
		die "Neovim is not installed or not in PATH."
	fi

	readonly NVIM_INSTALL_PATH=$(command -v nvim)
	log_info "Detected Neovim installation at: ${NVIM_INSTALL_PATH}"

	# Check if we can write to the installation path
	if [[ ! -w "$(dirname "${NVIM_INSTALL_PATH}")" ]]; then
		log_warning "No write permission to $(dirname "${NVIM_INSTALL_PATH}")"
		log_info "We'll need sudo privileges to update Neovim."
		readonly NEED_SUDO=true
	else
		readonly NEED_SUDO=false
	fi
}

# Get current and latest Neovim versions
get_versions() {
	# Get the currently installed version
	readonly CURRENT_VERSION=$("${NVIM_INSTALL_PATH}" --version | head -n 1 | awk '{print $2}' | sed 's/^v//')
	if [[ -z "${CURRENT_VERSION}" ]]; then
		die "Failed to determine current Neovim version."
	fi
	log_info "Current Neovim version: ${CURRENT_VERSION}"

	# Get the latest version tag from GitHub
	readonly NVIM_LATEST_URL="https://github.com/neovim/neovim/releases/latest"
	log_info "Checking for latest version..."

	LATEST_VERSION=$(curl -sL -o /dev/null -w "%{url_effective}" "${NVIM_LATEST_URL}" | awk -F'/' '{print $NF}' | sed 's/^v//')
	if [[ -z "${LATEST_VERSION}" ]]; then
		die "Failed to fetch the latest Neovim version."
	fi
	log_info "Latest Neovim version: ${LATEST_VERSION}"

	# Compare versions
	if [[ "${CURRENT_VERSION}" == "${LATEST_VERSION}" ]]; then
		log_success "Neovim is already up-to-date (version: ${CURRENT_VERSION})."
		exit 0
	fi
}

# Download the latest Neovim AppImage
download_neovim() {
	local download_url="https://github.com/neovim/neovim/releases/download/v${LATEST_VERSION}/nvim-linux-x86_64.appimage"

	log_info "Downloading Neovim AppImage from GitHub..."
	curl -L "${download_url}" -o "${NVIM_TMP_FILE}" --progress-bar || die "Download failed."

	if [[ ! -f "${NVIM_TMP_FILE}" ]]; then
		die "Download file not found."
	fi

	# Make the file executable
	chmod +x "${NVIM_TMP_FILE}"
	log_success "Download completed successfully."
}

# Install the new Neovim AppImage
install_neovim() {
	log_info "Installing Neovim ${LATEST_VERSION}..."

	# Create backup of current installation
	local backup_file="${HOME}/.nvim_backup_${CURRENT_VERSION}"
	log_info "Creating backup at ${backup_file}"
	cp "${NVIM_INSTALL_PATH}" "${backup_file}" || log_warning "Failed to create backup."

	# Replace the current Neovim binary
	if [[ "${NEED_SUDO}" == true ]]; then
		log_info "Using sudo to install Neovim..."
		sudo mv "${NVIM_TMP_FILE}" "${NVIM_INSTALL_PATH}" || die "Failed to install Neovim. Try running the script with sudo."
	else
		mv "${NVIM_TMP_FILE}" "${NVIM_INSTALL_PATH}" || die "Failed to install Neovim."
	fi

	# Verify installation
	local installed_version=$("${NVIM_INSTALL_PATH}" --version | head -n 1 | awk '{print $2}' | sed 's/^v//')
	if [[ "${installed_version}" != "${LATEST_VERSION}" ]]; then
		log_error "Verification failed. Installed version: ${installed_version}, Expected: ${LATEST_VERSION}"
		log_info "Restoring backup..."

		if [[ "${NEED_SUDO}" == true ]]; then
			sudo mv "${backup_file}" "${NVIM_INSTALL_PATH}"
		else
			mv "${backup_file}" "${NVIM_INSTALL_PATH}"
		fi
		die "Update failed. Restored previous version."
	fi

	log_success "Neovim updated successfully to version ${LATEST_VERSION}!"
	log_info "A backup of the previous version was saved to ${backup_file}"
}

# Display help message
show_help() {
	cat <<EOF
Usage: $(basename "$0") [OPTIONS]

A script to update Neovim to the latest version.

Options:
  -h, --help     Show this help message and exit
  -f, --force    Force update even if already on latest version
  -c, --check    Only check for updates, don't install
  --no-backup    Skip creating a backup of the current installation

EOF
}

# Parse command line arguments
parse_args() {
	FORCE_UPDATE=false
	CHECK_ONLY=false
	CREATE_BACKUP=true

	while [[ $# -gt 0 ]]; do
		case "$1" in
		-h | --help)
			show_help
			exit 0
			;;
		-f | --force)
			FORCE_UPDATE=true
			shift
			;;
		-c | --check)
			CHECK_ONLY=true
			shift
			;;
		--no-backup)
			CREATE_BACKUP=false
			shift
			;;
		*)
			log_error "Unknown option: $1"
			show_help
			exit 1
			;;
		esac
	done
}

# Main function
main() {
	parse_args "$@"
	log_info "Neovim Updater v1.0.0"

	check_dependencies
	get_system_info
	find_neovim
	get_versions

	if [[ "${FORCE_UPDATE}" == true ]]; then
		log_info "Forcing update due to --force flag."
	elif [[ "${CURRENT_VERSION}" == "${LATEST_VERSION}" ]]; then
		log_success "Neovim is already up-to-date (version: ${CURRENT_VERSION})."
		exit 0
	fi

	if [[ "${CHECK_ONLY}" == true ]]; then
		if [[ "${CURRENT_VERSION}" != "${LATEST_VERSION}" ]]; then
			log_info "An update is available: ${CURRENT_VERSION} → ${LATEST_VERSION}"
		fi
		exit 0
	fi

	log_info "Updating Neovim from ${CURRENT_VERSION} to ${LATEST_VERSION}..."
	download_neovim
	install_neovim

	log_success "Neovim ${LATEST_VERSION} is ready to use!"
}

# Execute main function
main "$@"
