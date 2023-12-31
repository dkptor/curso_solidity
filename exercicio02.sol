// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Exercicio02 {
    string public nomeLocador;
    string public nomeLocatario;
    uint256[36] public valorAluguel36Meses;

    constructor(string memory _nomeLocador,
                string memory _nomeLocatario,
                uint256 _valorAluguelInicial)  {

        uint8 i;
        
        nomeLocador = _nomeLocador;
        nomeLocatario = _nomeLocatario;
        for (i=0;i<36;i++){
            valorAluguel36Meses[i] = _valorAluguelInicial;
        }
    }

    function showValorALuguelByMes(uint8 _mes) public view returns (uint256) {
        return valorAluguel36Meses[_mes -1];
    }

    function showNomesDoLocadorELocatario() public view returns (string memory, string memory) {
        return (nomeLocador, nomeLocatario);
    }    

    function setNameByType(uint8 _type, string calldata _valorNovoNome) public returns (bool) {
        if (_type == 1){
            nomeLocador = _valorNovoNome;  
        } else if (_type == 2) {
            nomeLocatario = _valorNovoNome;
        }
        return true;
    }    

    function setReajusteAluguel(uint8 _mesAtual, uint256 _valorReajuste) public returns (bool) {
        uint8 i;
        for (i=_mesAtual;i<36;i++){
            valorAluguel36Meses[i] = valorAluguel36Meses[i] + _valorReajuste;
        }
        return true;
    }        
}
//Exercicio02.(constructor) 
//Contrato: 0x18b186545aD5B4016F3D62cB2526752bD5B2DC83
