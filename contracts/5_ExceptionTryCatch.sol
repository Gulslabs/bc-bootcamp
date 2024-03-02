// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract WillThrowExceptions {
    
    error CustomError(string);

    function throwRequire() public pure {
        require(false, "I am from require to be caught as error");
    }

    function throwAssert() public pure {
        assert(false);
    }

    function throwCustomExceptionWithRevert() public pure {
        revert CustomError("I am a custom error");
    }
}


contract HandleExceptions {
    WillThrowExceptions wt = new WillThrowExceptions(); 
    event RequireErrorEvent(string reason); 
    event AsserErrorCode(uint errorCode);
    //event CustomExceptionEvent(string reason);
    event CustomExceptionEvent(bytes reason);

    function handleRequire() external   {
        try wt.throwRequire() {
            // actual code that runs if there is no exception
        } catch Error(string memory reason) {
            emit RequireErrorEvent(reason);
        }
    }
    function handleAssert() external {
        try wt.throwAssert() {
            // actual code that runs if there is no exception
        } catch Panic(uint errorCode) {
            emit AsserErrorCode(errorCode);
        }
    }

    function handleCustomException() external {
        try wt.throwCustomExceptionWithRevert() {
            // actual code that runs if there is no exception
        } catch(bytes memory reason) {
            emit CustomExceptionEvent(reason);
        }
    }

}