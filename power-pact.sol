pragma solidity ^0.4.25;

contract PowerPact {
    uint public stake;
    uint public pactStart;
    uint public pactEnd;
    address public stakerAddress;
    address public counterPartyAddress;
    uint[] public attestations;
    
    function setStake() public payable {
        require(stake == 0, "stake already set");
        require(stakerAddress == 0, "stakerAddress already set");
        require(pactEnd == 0, "pactEnd already set");
        require(counterPartyAddress != 0, "counterPartyAddress must be set");
        require(msg.value > 0, "You must stake an amount greater than 0");
        
        stake = msg.value;
        stakerAddress = msg.sender;
        pactStart = now;
        pactEnd = now + 3600 * 7;
    }
    
    function setCounterPartyAddress(address _counterPartyAddress) public {
        require(counterPartyAddress == 0, "counterPartyAddress already set");
        
        counterPartyAddress = _counterPartyAddress;
    }
    
    function requestStake() public {
        require(stakerAddress != 0, "stakerAddress has not been set");
        require(counterPartyAddress != 0, "counterPartyAddress has not been set");
        require(now >= pactEnd, "The pact has not yet ended");
        require(stake > 0, "There is no more stake");
        
        if (attestations.length < 7) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        uint dayInSeconds = 3600;
        
        if (attestations[0] >= pactStart && attestations[0] < pactStart + dayInSeconds) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        if (attestations[1] >= pactStart + dayInSeconds && attestations[10] < pactStart + dayInSeconds * 2) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        if (attestations[2] >= pactStart + dayInSeconds * 2 && attestations[2] < pactStart + dayInSeconds * 3) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        if (attestations[3] >= pactStart + dayInSeconds * 3 && attestations[3] < pactStart + dayInSeconds * 4) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        if (attestations[4] >= pactStart + dayInSeconds * 4 && attestations[4] < pactStart + dayInSeconds * 5) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        if (attestations[5] >= pactStart + dayInSeconds * 5 && attestations[5] < pactStart + dayInSeconds * 6) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        if (attestations[6] >= pactStart + dayInSeconds * 6 && attestations[6] < pactStart + dayInSeconds * 7) {
            counterPartyAddress.transfer(stake);
            return;
        }
        
        stakerAddress.transfer(stake);
    }
    
    function attest() public {
        require(counterPartyAddress != 0, "counterPartyAddress must be set");
        require(stakerAddress != 0, "stakerAddress must be set");
        require(now < pactEnd, "The pact has ended");
        require(msg.sender == stakerAddress, "Only the staker can attest");
        attestations.push(now);
    }
}
