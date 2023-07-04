// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract CONET_NFT is ERC1155, Ownable  {
    
    string public constant name = "CONET Genesis Supporter Club";
    string public constant symbol = "CONET";
    uint256 public constant SPLITING = 1;
    uint256 public constant PLASMA = 2;
    uint256 public constant DROGAN = 3;
    uint256 public constant RHAEGAL = 4;
    uint256 public constant TENSOR = 5;
    uint256 public constant MATRIX = 6;
    uint256 public constant MINER = 7;
    uint256 public constant VISERION = 8;
    uint256 public constant BLACKHOLE = 9;
    uint256 public constant FISSION = 10;
    mapping (address => bool) public blockedTransferors;

    constructor() ERC1155 ( "https://openpgp.online/api/conet/nft/og/{id}") {
        for (uint256 i = 1; i < 11; i++) {
            _mint(msg.sender, i, 100, "");
        }
    }

    /**
    * @dev Returns the total quantity for a token ID
    * @param _id uint256 ID of the token to query
    * @return amount of token in existence
    */
    function totalSupply(
        uint256 _id
    ) public view returns (uint256) {
        return 100;
    }

    /**
     * @notice Returns a custom URI for each token id if set
     */
    function uri(
        uint256 _tokenId
    ) public view override returns (string memory) {
        // If no URI exists for the specific id requested, fallback to the default ERC-1155 URI.
        return (
            string (abi.encodePacked("https://openpgp.online/api/conet/nft/og/", Strings.toString(_tokenId))) 
        );
    }

    function blockTransferor(address _transferor) public onlyOwner {
        blockedTransferors[_transferor] = true;
    }

    function unblockTransferor(address _transferor) public onlyOwner {
        delete blockedTransferors[_transferor];
    }

    function isTransferorBlocked(address _transferor) public view returns (bool) {
        return blockedTransferors[_transferor];
    }

    function _beforeTokenTransfer(
        address operator,
        address _from,
        address _to,
        uint256[] memory ids, 
        uint256[] memory amounts, 
        bytes memory data
    ) internal virtual override {
        
        require(blockedTransferors[msg.sender] != true, 'Transferor is blocked');
        super._beforeTokenTransfer(operator, _from, _to, ids, amounts, data);
    }

    
}