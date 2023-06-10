// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Exercicio01 {
    string public nomeVendedor;
    uint256 private fatorBonus;

    constructor(string memory vendedor, uint256 fator)  {
        nomeVendedor = vendedor;
        fatorBonus = fator;
    }

    function calculaBonusVenda(uint256 valorVenda) public view returns (uint256) {
    return valorVenda * fatorBonus;
    }
}
//Exercicio01.(constructor)
//0x99caa1d4ebf27ec78775eeba2c67fc3e9cc8e3a14cee6669f8a50a3a15dfe927
