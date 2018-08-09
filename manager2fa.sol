pragma solidity ^0.4.21;


contract manager2FA {
    
    mapping(address => bool) public registeredAgent;
    modifier onlyRegisteredAgent {

    require(registeredAgent[msg.sender] == true);
    _;
    }
    
    //time in unix timestamp
    uint256 constant TIMELIMIT = 500;
    mapping(address => uint) public codesToAddress;    
    mapping(address => mapping(uint256 => uint256)) public addressToDatatoTime;
    address public owner;
    //getters
    
    constructor(){
        owner = msg.sender;
    }
     function verifyTx(address _sender, uint256 _2FAcode) returns (bool){
        //check that timelimit is not expired by checking the timestamp the code was generated + 500.
        require(now < (addressToDatatoTime[_sender][_2FAcode] +500));
        // needs to verify that the person has the correct 2FA
        require(codesToAddress[_sender] == _2FAcode);
        return true;
                }
    
    //set 2FA called from registeredAgent which is running on the backend of some companies servers
       function set2FA(address _sender, uint256 _2FAcode) 
       onlyRegisteredAgent 
       returns (uint256)  
      {
            codesToAddress[_sender] = _2FAcode;
            //this setting the time on the code for that address, to the current time. 
            addressToDatatoTime[_sender][_2FAcode] = now;
            
        return addressToDatatoTime[_sender][_2FAcode];
            
        }
    
    function registerAgent(address _agent) returns (bool){  
        require(msg.sender == owner);
        require(registeredAgent[_agent] == false);
        registeredAgent[_agent] = true;
        return registeredAgent[_agent];
    }
    
}


