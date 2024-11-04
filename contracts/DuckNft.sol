// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyDuck is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    uint256 MAX_SUPPLY = 100;
    event nftTransferEvent(
        address _from,
        address _to,
        uint _tokenId,
        uint price
    );
    event mintEvent(address to, uint tokenId, string uri);

    constructor(
        address initialOwner
    ) ERC721("MyDuck", "DUCK") Ownable(initialOwner) {}

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _nextTokenId++;
        require(tokenId <= MAX_SUPPLY, "I'm sorry we reached the cap");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        emit mintEvent(to, tokenId, uri);
    }

    // The following functions are overrides required by Solidity.
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //监听transfer的方法
    function nftTransfer(address _from, address _to, uint _tokenId) public {
        _safeTransfer(msg.sender, _to, _tokenId);
        emit nftTransferEvent(_from, _to, _tokenId, 0); // 这里的0是区分直接转移，而不是buy的
    }

    // 用于购买已经铸造的NFT
    function buy(uint256 tokenId) public payable {
        address owner = ownerOf(tokenId);
        require(owner != address(0), "Token does not exist");
        require(msg.sender != owner, "You cannot buy your own token");
        require(msg.value > 0, "ETH value must be greater than zero");

        // 将NFT从当前拥有者转移到购买者
        _safeTransfer(owner, msg.sender, tokenId, "");

        // 将ETH转移给卖家
        payable(owner).transfer(msg.value);

        emit nftTransferEvent(owner, msg.sender, tokenId, msg.value);
    }
}

//此方法已经转到数据库做处理，暂时是不需要了
// function walletOfOwner(
//     address owner
// ) public view returns (uint256[] memory) {
//     uint256 ownerTokenCount = balanceOf(owner);
//     uint256[] memory tokenIds = new uint256[](ownerTokenCount);
//     for (uint256 i; i < ownerTokenCount; i++) {
//         tokenIds[i] = tokenOfOwnerByIndex(owner, i);
//     }
//     return tokenIds;
// }
