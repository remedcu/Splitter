pragma solidity >=0.4.22 <0.6.0;

import "./Owned.sol";

// Inspiration from B9Lab Module 3 Solidity Inheritance Screencast
contract Stoppable is Owned {

    bool private isRunning;
    bool private isStopped;

    event LogPausedContract(address sender);
    event LogResumedContract(address sender);
    event LogStoppedContract(address sender);

    modifier onlyIfRunning {
        require(isRunning, "Contract is Paused at the moment");
        require(!isStopped, "Contract is Stopped permanently");
        _;
    }

    modifier onlyIfPaused {
        require(!isRunning, "Contract is Running at the moment");
        _;
    }

    constructor(bool startState) public {
        isRunning = startState;
        isStopped = false;
    }

    function pauseContract() public onlyOwner onlyIfRunning returns(bool success){
        isRunning = false;
        emit LogPausedContract(msg.sender);
        return true;
    }

    function resumeContract() public onlyOwner onlyIfPaused returns(bool success){
        isRunning = true;
        emit LogResumedContract(msg.sender);
        return true;
    }

    function stopContract() public onlyOwner onlyIfPaused returns(bool success){
        isStopped = true;
        emit LogStoppedContract(msg.sender);
        return true;
    }

}
