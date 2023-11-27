// SPDX-License-Identifier: MIT
pragma solidity ^0.6.4;

contract Voting {
    mapping(bytes32 => uint256) private votesReceived;
    bytes32[] private candidateList;
    bool private initialized;

    function initialize(string memory candidateName1, string memory candidateName2, string memory candidateName3) public {
        require(!initialized, "Contract already initialized");

        bytes32 candidate1 = keccak256(abi.encodePacked(candidateName1));
        bytes32 candidate2 = keccak256(abi.encodePacked(candidateName2));
        bytes32 candidate3 = keccak256(abi.encodePacked(candidateName3));

        candidateList.push(candidate1);
        candidateList.push(candidate2);
        candidateList.push(candidate3);

        initialized = true;
    }

    function totalVotesFor(string memory candidateName) view public returns (uint256) {
        bytes32 candidate = keccak256(abi.encodePacked(candidateName));
        require(validCandidate(candidate), "Invalid candidate");
        return votesReceived[candidate];
    }

    function voteForCandidate(string memory candidateName) public {
        bytes32 candidate = keccak256(abi.encodePacked(candidateName));
        require(validCandidate(candidate), "Invalid candidate");
        votesReceived[candidate] += 1;
    }

    receive() external payable {
        // You can implement any logic you want when receiving Ether.
        // This function is optional if you don't plan to receive Ether directly.
    }
    
    fallback() external payable {
        // Similar to the receive() function, you can implement logic here.
    }

    // Helper function to check if a candidate is valid
    function validCandidate(bytes32 candidate) private view returns (bool) {
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}
