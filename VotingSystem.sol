// SPDX-License-Identifier: MIT
pragma solidity ^0.6.4;

contract Voting {
    
    mapping(bytes32 => uint256) private votesReceived; // Map that store the number of votes received for each candidate
    bytes32[] private candidateList; //Array that stores the candidates
    bool private initialized; //function that tracks whether the contratacs has been initialized

    //Function that initializes the contract with the candidate name
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

    //Function to get the total votes for each candidate
    function totalVotesFor(string memory candidateName) view public returns (uint256) {
        bytes32 candidate = keccak256(abi.encodePacked(candidateName));
        require(validCandidate(candidate), "Invalid candidate");
        return votesReceived[candidate];
    }

    //Function to vote in a candidate
    function voteForCandidate(string memory candidateName) public {
        bytes32 candidate = keccak256(abi.encodePacked(candidateName));
        require(validCandidate(candidate), "Invalid candidate");
        votesReceived[candidate] += 1;
    }

    //Fallback function in order to the Contract works
    receive() external payable {
    }
    
    fallback() external payable {
    }

    //Function to check if a candidate is valid
    function validCandidate(bytes32 candidate) private view returns (bool) {
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}
