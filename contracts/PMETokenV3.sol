// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

/**
 * @title PMETokenV3
 * @dev ERC20 Token Contract with Upgradeability.
 * This contract allows for token minting, burning, and transfer functionality while supporting pausing and ownership management.
 */
contract PMETokenV3 is
    Initializable,
    ERC20Upgradeable,
    OwnableUpgradeable,
    PausableUpgradeable
{
    /// @dev Total supply of the token (35 billion with 6 decimals).
    uint256 private constant TOTAL_SUPPLY = 35_000_000_000 * (10 ** 18);

    /**
     * @dev Initializes the token with the specified parameters.
     * Mints the entire supply at deployment and assigns it to the deployer's address.
     * @param _name The name of the token.
     * @param _symbol The symbol of the token.
     */
    function initialize(
        string memory _name,
        string memory _symbol
    ) public initializer {
        __ERC20_init(_name, _symbol);
        __Ownable_init(msg.sender);
        __Pausable_init();
        _mint(msg.sender, TOTAL_SUPPLY);
    }

    /**
     * @dev Pauses all token transfers. Only the owner can call this function.
     * This function can be used to halt all token operations in case of emergency.
     */
    function pause() external onlyOwner {
        _pause();
        emit Paused(msg.sender);
    }

    /**
     * @dev Unpauses all token transfers. Only the owner can call this function.
     * This function resumes token operations after being paused.
     */
    function unpause() external onlyOwner {
        _unpause();
        emit Unpaused(msg.sender);
    }

    /**
     * @dev Burns a specific amount of tokens from the caller's account.
     * @param amount The amount of tokens to burn. Must be greater than zero.
     * @return A boolean indicating whether the burn was successful.
     */
    function burn(uint256 amount) external whenNotPaused returns (bool) {
        require(amount > 0, "Burn amount must be greater than zero");
        _burn(msg.sender, amount);
        return true;
    }

    /**
     * @dev Override transfer function to include whenNotPaused modifier.
     * This ensures that token transfers are not allowed when the contract is paused.
     * @param recipient The address to receive the tokens.
     * @param amount The amount of tokens to transfer.
     * @return A boolean indicating whether the transfer was successful.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) public virtual override whenNotPaused returns (bool) {
        return super.transfer(recipient, amount);
    }

    /**
     * @dev Override transferFrom function to include whenNotPaused modifier.
     * This ensures that token transfers are not allowed when the contract is paused.
     * @param sender The address sending the tokens.
     * @param recipient The address to receive the tokens.
     * @param amount The amount of tokens to transfer.
     * @return A boolean indicating whether the transfer was successful.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override whenNotPaused returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }
}
