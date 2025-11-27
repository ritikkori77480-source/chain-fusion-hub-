// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Chain Fusion Hub
 * @dev A simple smart contract demonstrating project registration and ownership.
 */
contract Project {
    struct ProjectInfo {
        string name;
        string description;
        address owner;
        uint256 timestamp;
    }

    mapping(uint256 => ProjectInfo) public projects;
    uint256 public projectCount;

    event ProjectCreated(
        uint256 indexed projectId,
        string name,
        address indexed owner
    );

    event ProjectUpdated(
        uint256 indexed projectId,
        string newDescription
    );

    /**
     * @dev Create a new project.
     * @param _name Name of the project.
     * @param _description Description of the project.
     */
    function createProject(string memory _name, string memory _description) external {
        projectCount += 1;

        projects[projectCount] = ProjectInfo({
            name: _name,
            description: _description,
            owner: msg.sender,
            timestamp: block.timestamp
        });

        emit ProjectCreated(projectCount, _name, msg.sender);
    }

    /**
     * @dev Update the description of an existing project.
     * @param _projectId ID of the project to update.
     * @param _newDescription New description.
     */
    function updateProject(uint256 _projectId, string memory _newDescription) external {
        require(projects[_projectId].owner == msg.sender, "Not the project owner");

        projects[_projectId].description = _newDescription;

        emit ProjectUpdated(_projectId, _newDescription);
    }

    /**
     * @dev Return project details.
     * @param _projectId Project ID.
     */
    function getProject(uint256 _projectId)
        external
        view
        returns (ProjectInfo memory)
    {
        return projects[_projectId];
    }
}

