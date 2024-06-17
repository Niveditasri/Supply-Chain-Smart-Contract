// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    enum Role { None, Manufacturer, Supplier, Retailer }
    enum State { Created, InTransit, Delivered }

    struct Participant {
        address addr;
        Role role;
    }

    struct Product {
        uint256 id;
        string name;
        address manufacturer;
        address currentOwner;
        State state;
    }

    address public owner;
    uint256 public productCounter;
    mapping(address => Participant) public participants;
    mapping(uint256 => Product) public products;

    event ParticipantAdded(address addr, Role role);
    event ProductCreated(uint256 productId, string name, address manufacturer);
    event ProductTransferred(uint256 productId, address from, address to);
    event ProductDelivered(uint256 productId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyManufacturer() {
        require(participants[msg.sender].role == Role.Manufacturer, "Only manufacturers can perform this action");
        _;
    }

    modifier onlySupplier() {
        require(participants[msg.sender].role == Role.Supplier, "Only suppliers can perform this action");
        _;
    }

    modifier onlyRetailer() {
        require(participants[msg.sender].role == Role.Retailer, "Only retailers can perform this action");
        _;
    }

    modifier productExists(uint256 productId) {
        require(products[productId].id == productId, "Product does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addParticipant(address addr, Role role) public onlyOwner {
        require(role != Role.None, "Invalid role");
        require(participants[addr].role == Role.None, "Participant already exists");
        
        participants[addr] = Participant(addr, role);
        emit ParticipantAdded(addr, role);
    }

    function createProduct(string memory name) public onlyManufacturer {
        products[productCounter] = Product(productCounter, name, msg.sender, msg.sender, State.Created);
        emit ProductCreated(productCounter, name, msg.sender);
        productCounter++;
    }

    function transferProduct(uint256 productId, address to) public productExists(productId) {
        Product storage product = products[productId];
        require(product.currentOwner == msg.sender, "Only the current owner can transfer this product");
        require(participants[to].role != Role.None, "Recipient must be a participant");

        product.currentOwner = to;
        product.state = State.InTransit;
        emit ProductTransferred(productId, msg.sender, to);
    }

    function deliverProduct(uint256 productId) public onlyRetailer productExists(productId) {
        Product storage product = products[productId];
        require(product.currentOwner == msg.sender, "Only the current owner can mark as delivered");

        product.state = State.Delivered;
        emit ProductDelivered(productId);
    }

    function getProduct(uint256 productId) public view productExists(productId) returns (string memory, address, address, State) {
        Product memory product = products[productId];
        return (product.name, product.manufacturer, product.currentOwner, product.state);
    }
}
