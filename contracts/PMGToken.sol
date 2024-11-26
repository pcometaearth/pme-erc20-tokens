// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title PMGToken
 * @dev An upgradeable ERC20 token contract with pausing and role-based minting functionality.
 * The contract follows the OpenZeppelin's upgradeable patterns and allows minting up to a maximum supply.
 */
contract PMGToken is
    Initializable,
    ERC20Upgradeable,
    AccessControlUpgradeable,
    PausableUpgradeable
{
    uint256 public constant MAX_SUPPLY = 35_000_000_000 * 10 ** 18; // 35 billion tokens with 18 decimals
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @notice Initializes the PMGToken contract with a name and symbol.
     * @dev This function replaces the constructor in upgradeable contracts.
     * It initializes inherited contracts and sets up roles.
     * @param _name The name of the token.
     * @param _symbol The symbol of the token.
     */
    function initialize(
        string memory _name,
        string memory _symbol
    ) public initializer {
        __ERC20_init(_name, _symbol);
        __AccessControl_init();
        __Pausable_init();

        // Grant the minter role to the deployer
        _grantRole(MINTER_ROLE, _msgSender());
    }

    /**
     * @notice Mints new tokens to a specified address.
     * @dev Only accounts with the MINTER_ROLE can call this function.
     * The function checks the total supply to ensure the max supply is not exceeded.
     * @param to The address to receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function mint(
        address to,
        uint256 amount
    ) external onlyRole(MINTER_ROLE) whenNotPaused {
        require(
            totalSupply() + amount <= MAX_SUPPLY,
            "PMGToken: Max supply exceeded"
        );
        _mint(to, amount);
    }

    /**
     * @notice Pauses all token transfers.
     * @dev Only the contract owner can call this function.
     * While paused, all token transfers will be blocked.
     */
    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    /**
     * @notice Unpauses all token transfers.
     * @dev Only the contract owner can call this function.
     * Token transfers will be allowed once unpaused.
     */
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }
}
