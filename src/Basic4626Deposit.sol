// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

interface IERC20Like {
    function balanceOf(address) external view returns (uint256);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract Basic4626Deposit {
    ////////////////////
    // Storage for the contract
    ////////////////////
    address public immutable asset;

    string public name;
    string public symbol;

    uint8 public immutable decimals;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    ////////////////////
    // Constructor
    ////////////////////

    constructor(
        address asset_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) {
        asset = asset_;
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
    }

    ////////////////////
    // External functions
    ////////////////////
    function deposit(
        uint256 assets_,
        address receiver_
    ) external returns (uint256 shares_) {
        shares_ = convertToShares(assets_);

        require(receiver_ != address(0), "ZERO_RECEIVER");
        require(shares_ != uint256(0), "ZERO_SHARES");
        require(assets_ != uint256(0), "ZERO_ASSETS");

        totalSupply += shares_;

        // Cannot overflow because totalSupply would first overflow in the statement above
        unchecked {
            balanceOf[receiver_] += shares_;
        }

        require(
            IERC20Like(asset).transferFrom(msg.sender, address(this), assets_),
            "transferFrom failed"
        );
    }

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool) {
        require(recipient != address(0), "ZERO_RECIPIENT");
        require(amount != uint256(0), "ZERO_AMOUNT");
        require(balanceOf[msg.sender] >= amount, "INSUFFICIENT_BALANCE");

        unchecked {
            balanceOf[msg.sender] -= amount;
            balanceOf[recipient] += amount;
        }

        return true;
    }

    ////////////////////
    // Public view functions
    ////////////////////

    function convertToShares(
        uint256 assets_
    ) public view returns (uint256 shares_) {
        uint256 supply = totalSupply;

        shares_ = supply == 0 ? assets_ : (assets_ * supply) / totalAssets();
    }

    function totalAssets() public view returns (uint256) {
        return IERC20Like(asset).balanceOf(address(this));
    }
}
