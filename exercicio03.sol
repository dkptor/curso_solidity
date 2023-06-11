// Modifier 
// Revert ok
// Struct ok
// Require ok

// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract Exercicio03 {

    struct dadosAluguel {
        string nomeLocador;
        string nomeLocatario;
        uint256[36] valorAluguel36Meses;
    }

    dadosAluguel public contrato;

    constructor(string memory _nomeLocador,
                string memory _nomeLocatario,
                uint256 _valorAluguelInicial)  {

        uint8 i;
        
        contrato.nomeLocador = _nomeLocador;
        contrato.nomeLocatario = _nomeLocatario;
        for (i=0;i<36;i++){
            contrato.valorAluguel36Meses[i] = _valorAluguelInicial;
        }
    }

    modifier onlyValidNumber(uint _number, string memory _descricao) {
        require(_number > 0, string.concat(_descricao, " invalido !"));
        _;
    }

    modifier onlyValidString(string memory _value, string memory _descricao) {
        require(keccak256(bytes(_value)) != keccak256(""), string.concat(_descricao, " invalido !"));
        _;
    }    

    function showValorALuguelByMes(uint8 _mes) 
        public view 
        onlyValidNumber(_mes, "Mes") 
        returns (uint256) {
            return contrato.valorAluguel36Meses[_mes -1];
    }

    function showNomesDoLocadorELocatario() 
        public view 
        returns (string memory, string memory) {
            return (contrato.nomeLocador, contrato.nomeLocatario);
    }    

    function setNameByType(uint8 _type, string calldata _valorNovoNome) 
        public 
        onlyValidString(_valorNovoNome, "Novo nome")
        returns (bool) {
            require(_type == 1 || _type == 2, "Type informado invalido!");
            if (_type == 1){
                contrato.nomeLocador = _valorNovoNome;  
            } else if (_type == 2) {
                contrato.nomeLocatario = _valorNovoNome;
            }
            return true;
    }    

    function setReajusteAluguelAposMesInformado(uint8 _mesInformado, uint256 _valorReajuste) 
    public
    onlyValidNumber(_mesInformado, "Mes")
    onlyValidNumber(_valorReajuste, "Valor")
    returns (bool) {
        if (_mesInformado > 36) {
            revert("Mes informado nao esta no contrato");
        }

        uint8 i;
        for (i=_mesInformado;i<36;i++){
            contrato.valorAluguel36Meses[i] = contrato.valorAluguel36Meses[i] + _valorReajuste;
        }
        return true;
    }        
}
//Exercicio03.(constructor) 
//Contrato: 0x5e06fdfd9dbd2ffb2e9def64265769a26796c105
//Transaction: 0xab29d1f083bf7f3e8fde01ebca0082e0275bb4c0a601e20718693e654c649722
