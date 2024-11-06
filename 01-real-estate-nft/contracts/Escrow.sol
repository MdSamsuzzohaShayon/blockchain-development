// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/**
 * @title IERC721
 * @dev This is an interface for interacting with ERC721 NFT contracts.
 * Only the `transferFrom` function is included here, as it is the one needed
 * for transferring ownership of an NFT.
 * 
 * `transferFrom` allows the transfer of an NFT from one address to another.
 * By defining it in this interface, we ensure the Escrow contract can interact
 * with any NFT contract that follows the ERC721 standard.
 */
interface IERC721 {
    function transferFrom(address _from, address _to, uint256 _id) external;
}

/**
 * @title Escrow
 * @dev This contract manages the sale of NFTs via an escrow system, ensuring that
 * funds and NFTs are only transferred when all parties (seller, buyer, inspector, lender)
 * agree. This is useful for higher-value assets where additional checks (like inspections)
 * are necessary before a sale is completed.
 */
contract Escrow {
    // Address of the NFT contract that manages the NFTs being sold.
    address public nftAddress;

    // Seller's address. They are the owner of the NFT initially.
    address payable public seller;

    // Inspector's address. They check the NFT or related asset, ensuring it's satisfactory.
    address public inspector;

    // Lender's address. They provide funds for the buyer if needed.
    address public lender;

    // Modifier to restrict function access to only the seller
    // We use this to enforce that only the seller can list an NFT for sale.
    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this method");
        _;
    }

    // Modifier to restrict function access to only the specific buyer of an NFT
    // This prevents others from attempting to interact with a sale they aren't part of.
    modifier onlyBuyer(uint256 _nftID) {
        require(msg.sender == buyer[_nftID], "Only buyer can call this method");
        _;
    }

    // Modifier to restrict function access to only the inspector
    // Used to ensure that only the assigned inspector can approve or fail an inspection.
    modifier onlyInspector() {
        require(msg.sender == inspector, "Only inspector can call this method");
        _;
    }

    // Mapping to track if an NFT is listed for sale.
    mapping(uint256 => bool) public isListed;

    // Mapping to record the agreed purchase price for each NFT.
    mapping(uint256 => uint256) public purchasePrice;

    // Mapping for the escrow amount (earnest money) required for each NFT.
    mapping(uint256 => uint256) public escrowAmount;

    // Mapping to track the buyer for each NFT. Only they can make payments or approve.
    mapping(uint256 => address) public buyer;

    // Mapping to store inspection status for each NFT.
    // If false, the buyer can cancel the sale and get their deposit back.
    mapping(uint256 => bool) public inspectionPassed;

    // Nested mapping to track approval from multiple parties for each NFT sale.
    // This ensures all parties agree before the sale can proceed.
    mapping(uint256 => mapping(address => bool)) public approval;

    /**
     * @dev Constructor to set up the initial addresses for the contract.
     * @param _nftAddress Address of the NFT contract.
     * @param _seller Address of the seller who owns the NFT.
     * @param _inspector Address of the inspector for verification.
     * @param _lender Address of the lender providing funds.
     */
    constructor(address _nftAddress, address payable _seller, address _inspector, address _lender) {
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }

    /**
     * @dev Function to list an NFT for sale. Only callable by the seller.
     * Transfers the NFT from the seller to this contract for safekeeping until the sale completes.
     * @param _nftID The unique ID of the NFT being listed.
     * @param _buyer The address of the buyer.
     * @param _purchasePrice The agreed price of the NFT.
     * @param _escrowAmount The deposit amount required to start the transaction.
     */
    function list(uint256 _nftID, address _buyer, uint256 _purchasePrice, uint256 _escrowAmount)
        public
        payable
        onlySeller
    {
        // Transfer NFT from the seller to the contract.
        // This secures the NFT and prevents the seller from backing out after a buyer is interested.
        IERC721(nftAddress).transferFrom(msg.sender, address(this), _nftID);

        // Set listing details for the NFT.
        isListed[_nftID] = true;
        purchasePrice[_nftID] = _purchasePrice;
        escrowAmount[_nftID] = _escrowAmount;
        buyer[_nftID] = _buyer;
    }

    /**
     * @dev Allows the inspector to update the inspection status.
     * This step is crucial in real estate-type transactions where inspections verify asset conditions.
     * @param _nftID The unique ID of the NFT.
     * @param _passed Boolean value representing whether the inspection passed.
     */
    function updateInspectionStatus(uint256 _nftID, bool _passed) public payable onlyInspector {
        inspectionPassed[_nftID] = _passed;
    }

    /**
     * @dev Allows the buyer to deposit earnest money (escrow).
     * This shows the buyer's commitment to the transaction and is refundable depending on the inspection result.
     * @param _nftID The unique ID of the NFT.
     */
    function depositEarnest(uint256 _nftID) public payable onlyBuyer(_nftID) {
        require(msg.value >= escrowAmount[_nftID], "Insufficient earnest deposit");
    }

    /**
     * @dev Function for each party (buyer, seller, lender) to approve the sale.
     * All required parties must approve before the sale can proceed.
     * @param _nftID The unique ID of the NFT.
     */
    function approveSale(uint256 _nftID) public {
        approval[_nftID][msg.sender] = true;
    }

    /**
     * @dev Finalizes the sale after verifying that all conditions are met.
     * Transfers NFT to the buyer and the funds to the seller.
     * Conditions:
     * - Inspection must pass.
     * - All parties must approve.
     * - Correct funds should be in the contract.
     * @param _nftID The unique ID of the NFT.
     */
    function finalizeSale(uint256 _nftID) public {
        require(inspectionPassed[_nftID], "Inspection has not passed");
        require(approval[_nftID][buyer[_nftID]], "Buyer has not approved");
        require(approval[_nftID][seller], "Seller has not approved");
        require(approval[_nftID][lender], "Lender has not approved");
        require(address(this).balance >= purchasePrice[_nftID], "Insufficient funds to complete sale");

        // Mark the NFT as no longer listed to prevent duplicate sales.
        isListed[_nftID] = false;

        // Transfer the sale amount to the seller.
        (bool success,) = payable(seller).call{value: address(this).balance}("");
        require(success, "Transfer to seller failed");

        // Transfer the NFT to the buyer, finalizing ownership.
        IERC721(nftAddress).transferFrom(address(this), buyer[_nftID], _nftID);
    }

    /**
     * @dev Allows cancellation of the sale based on inspection status.
     * If the inspection failed, the buyer gets a refund.
     * If inspection passed but sale is canceled, funds go to the seller.
     * @param _nftID The unique ID of the NFT.
     */
    function cancelSale(uint256 _nftID) public {
        if (!inspectionPassed[_nftID]) {
            // Refund the earnest deposit to the buyer if the inspection failed.
            payable(buyer[_nftID]).transfer(address(this).balance);
        } else {
            // If inspection passed but sale is canceled, transfer funds to the seller.
            payable(seller).transfer(address(this).balance);
        }
    }

    // Allow contract to receive Ether
    receive() external payable {}

    /**
     * @dev Gets the current balance of the contract.
     * Useful for checking escrow balance.
     */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
