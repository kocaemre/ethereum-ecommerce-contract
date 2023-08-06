// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.1 <0.9.0;

contract ecommerce {
    address owner;

    // Mapping to keep track of authorized sellers
    mapping(address => bool) public is_seller;

    // Mapping to store user balances
    mapping(address => uint) balances;

    // Counter for product IDs
    uint private id = 1; // starts from 1

    // Mapping to store product information using product ID
    mapping(uint => Product_schema) public Products;

    // Commission rate for the platform manager (in percentage)
    uint commission = 10; // %10

    // Manager commission amount for a product purchase
    uint managerCommission;

    // Product structure to hold details of each product
    struct Product_schema {
        string name;
        uint price;
        uint stock;
        bool able_to_buying;
        address creator;
    }

    // Modifier to restrict certain functions to only the contract owner
    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Modifier to restrict certain functions to only authorized sellers or the contract owner
    modifier onlySeller {
        require(msg.sender == owner || is_seller[msg.sender] == true, "You are not a seller");
        _;
    }

    // Constructor initializes the contract with the owner's address
    constructor() {
        owner = msg.sender;
        is_seller[msg.sender] = true;
    }

    // Function to give seller permission to a specific address
    function seller_permission(address permission) public onlyOwner returns(bool) {
        require(is_seller[permission] == false, "Permission already granted");
        is_seller[permission] = true;
        return true;
    }

    // Function to get the balance of the caller
    function get_Balance() public view returns(uint) {
        return balances[msg.sender];
    }

    // Function to get the total balance of the contract
    function get_Balance_global() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    // Function to deposit Ether into the contract and update the caller's balance
    function deposit() payable public returns (bool) {
        require(msg.value > 0 wei, "You didn't send any money");
        balances[msg.sender] += msg.value;
        return true;
    }

    // Function to receive Ether when sent directly to the contract
    receive() payable external {
        deposit();
    }

    // Function to withdraw a specified amount of Ether from the caller's balance
    function withdraw(uint wei_amount) public returns(bool) {
        require(balances[msg.sender] >= wei_amount, "You don't have enough balance");
        uint money = wei_amount;
        address payable recipient = payable(msg.sender);
        balances[msg.sender] -= money;
        recipient.transfer(money);
        return true;
    }

    // Function to create a new product by sellers
    function createProduct(string calldata _name, uint _price, uint _stock) public onlySeller returns(bool) {
        Product_schema storage newProduct = Products[id];
        id++;

        newProduct.name = _name;
        newProduct.price = _price;
        newProduct.stock = _stock;
        newProduct.able_to_buying = true;
        newProduct.creator = msg.sender;

        return true;
    }

    // Function to buy a product by users
    function buyProduct(uint id_number) public returns(string memory) {
        require(Products[id_number].able_to_buying && balances[msg.sender] >= Products[id_number].price, "You can't buy that");

        Products[id_number].stock--;
        balances[msg.sender] -= Products[id_number].price;

        uint totalprice = Products[id_number].price;
        managerCommission = (totalprice / 100) * commission;

        balances[Products[id_number].creator] += (totalprice - managerCommission);
        balances[owner] += managerCommission;

        if (Products[id_number].stock == 0) {
            Products[id_number].able_to_buying = false;
        }

        return "Completed";
    }
}
