pragma solidity ^0.4.21;

import "./manager2fa.sol";

contract Test2FA {
    
    
     manager2FA instance;
    
    function setAddress(address _addr){
        
        instance = manager2FA(_addr);
    }
   function confirmCode(uint256 _2FAcode) returns (bool){
       require(instance.verifyTx(msg.sender, _2FAcode));
       return true;
       
   }
    
}