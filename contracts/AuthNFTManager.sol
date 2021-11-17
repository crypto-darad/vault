pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { AuthNFT } from "./AuthNFT.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";




contract NftAuthTokenManager {
    using SafeMath for uint;
    address[] authTokenList; 

    constructor(
    ) public {
    }

    function createAuthToken(address to, string memory ipfsHash) public returns (address _authToken) {
        AuthNFT authToken = new AuthNFT(to, ipfsHash);
        authTokenList.push(address(authToken));
        return address(authToken);
    }


    function getAuthTokenList() public view returns (address[] memory _authTokenList) {
        return authTokenList;
    }
    

}