// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Mapa {
    mapping(address => uint) public saldo;

    function setSaldo(address _conta, uint _valor) external returns(bool) {
        saldo[_conta] = _valor;
        return true;
    }
}
