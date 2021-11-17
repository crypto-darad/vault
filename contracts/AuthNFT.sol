pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import "@openzeppelin/contracts/access/AccessControl.sol";



contract AuthNFT is ERC721, AccessControl {
    using SafeMath for uint;

    uint public currentAuthTokenId;
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    constructor(
        address to,
        string memory ipfsHash
    ) 
        public ERC721("CryptoWealth Auth Token", "CWAT")
    {
        /// Grant the creator of this contract the default admin role: it will be able
        /// to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mintAuthToken(address to, string memory ipfsHash) public returns (uint _newAuthTokenId) {
        _mintAuthToken(to, ipfsHash);

        /// Grant an user who is minted the AuthToken the user-role
        _setupRole(USER_ROLE, to);
    }

    function _mintAuthToken(address to, string memory ipfsHash) internal returns (uint _newAuthTokenId) {
        uint newAuthTokenId = getNextAuthTokenId();
        currentAuthTokenId++;
        _mint(to, newAuthTokenId);
        _setTokenURI(newAuthTokenId, ipfsHash);  /// [Note]: Use ipfsHash as a password and metadata

        return newAuthTokenId;
    }

    /***
     * @notice - Login with Auth Token
     **/
    function loginWithAuthToken(uint authTokenId, address userAddress, string memory ipfsHash) public view returns (bool _isAuth) {
        /// [Note]: Check whether a login user has role or not
        require(hasRole(USER_ROLE, userAddress), "Caller is not a user");

        /// [Note]: Convert each value (data-type are string) to hash in order to compare with each other 
        bytes32 hash1 = keccak256(abi.encodePacked(ipfsHash));
        bytes32 hash2 = keccak256(abi.encodePacked(tokenURI(authTokenId)));

        /// Check 
        bool isAuth;
        if (userAddress == ownerOf(authTokenId)) {
            if (hash1 == hash2) {
                isAuth = true;
            }
        }

        return isAuth;
    }

    function getNextAuthTokenId() private view returns (uint nextAuthTokenId) {
        return currentAuthTokenId.add(1);
    }

}