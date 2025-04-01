pragma solidity ^0.8.0;

contract DynamicPricingToken {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    uint256 public basePrice = 1 ether; // Initial price per token
    uint256 public priceStep = 0.01 ether; // Price increase per volume step
    uint256 public volumeTraded;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy tokens");
        uint256 tokenPrice = getCurrentPrice();
        uint256 tokensToMint = msg.value / tokenPrice;
        require(tokensToMint > 0, "Not enough ETH for 1 token");

        balances[msg.sender] += tokensToMint;
        totalSupply += tokensToMint;
        volumeTraded += tokensToMint;
    }

    function sellTokens(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough tokens");

        uint256 tokenPrice = getCurrentPrice();
        uint256 etherValue = amount * tokenPrice;
        require(address(this).balance >= etherValue, "Not enough ETH in contract");

        balances[msg.sender] -= amount;
        totalSupply -= amount;
        volumeTraded -= amount;

        payable(msg.sender).transfer(etherValue);
    }

    function getCurrentPrice() public view returns (uint256) {
        return basePrice + (priceStep * volumeTraded / 1000); // Adjust price per volume traded
    }

    function depositETH() public payable onlyOwner {}

    function withdrawETH(uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Not enough ETH");
        payable(owner).transfer(amount);
    }
}
