// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Exercicio01 {
    string public nomeVendedor;
    uint256 public fatorBonus;

    constructor(string memory vendedor, uint256 fator)  {
        nomeVendedor = vendedor;
        fatorBonus = fator;
    }

    function calculaBonusVenda(uint256 valorVenda) public view returns (uint256) {
    return valorVenda * fatorBonus;
    }
}
//Exercicio01.(constructor)
//Transacao: 0xed3dad561fd320dd8687b3795c5265e6042ffa565393b214afe37f9f5f2ee0b5
//Contrato: 0xa5f8dd399b6b21f99a4c0727f534ed892910e249
