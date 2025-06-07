
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IdeaGraph {
    uint256 public ideaCount;

    struct Idea {
        uint256 id;
        address creator;
        string contentURI;
        uint256[] linkedIdeas;
    }

    mapping(uint256 => Idea) public ideas;
    mapping(uint256 => address[]) public endorsements;

    event IdeaCreated(uint256 indexed id, address indexed creator, string contentURI);
    event IdeaEndorsed(uint256 indexed id, address indexed endorser);
    event IdeaLinked(uint256 indexed fromId, uint256 indexed toId);

    function postIdea(string memory contentURI) public returns (uint256) {
        ideaCount++;
        ideas[ideaCount] = Idea(ideaCount, msg.sender, contentURI, new uint256[](0));
        emit IdeaCreated(ideaCount, msg.sender, contentURI);
        return ideaCount;
    }

    function endorseIdea(uint256 id) public {
        require(id > 0 && id <= ideaCount, "Invalid ID");
        endorsements[id].push(msg.sender);
        emit IdeaEndorsed(id, msg.sender);
    }

    function linkIdeas(uint256 fromId, uint256 toId) public {
        require(ideas[fromId].creator == msg.sender, "Not creator");
        ideas[fromId].linkedIdeas.push(toId);
        emit IdeaLinked(fromId, toId);
    }

    function getLinkedIdeas(uint256 id) public view returns (uint256[] memory) {
        return ideas[id].linkedIdeas;
    }

    function getEndorsers(uint256 id) public view returns (address[] memory) {
        return endorsements[id];
    }
}
