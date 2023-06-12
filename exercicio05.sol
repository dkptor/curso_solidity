//Exercicio05.(constructor)
//Contrato: 0xF52055a6994851aCfE05b81e9cC5Ed6c351199c5
//Transaction: 0xdfce19488c560efa0903bcbe85fdcc7e8ddbf84c5ec81b2368f924f05353a374

// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract Ownable {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner, address _newOwner)
        public
        onlyOwner
        returns (bool)
    {
        require(_owner == tx.origin, "_owner wrong.");
        owner = _newOwner;
        return true;
    }
}

contract Exercicio05 is Ownable {
    struct dadosAluguel {
        string nomeLocador;
        string nomeLocatario;
        bytes32 hashIdUnica;
        uint256[36] valorAluguel36Meses;
    }

    dadosAluguel public contrato;

    modifier makeHashId() {
        _;
        contrato.hashIdUnica = keccak256(
            bytes(string.concat(contrato.nomeLocador, contrato.nomeLocatario))
        );
    }

    constructor(
        string memory _nomeLocador,
        string memory _nomeLocatario,
        uint256 _valorAluguelInicial
    ) makeHashId() {
        uint8 i;

        contrato.nomeLocador = _nomeLocador;
        contrato.nomeLocatario = _nomeLocatario;
        for (i = 0; i < 36; i++) {
            contrato.valorAluguel36Meses[i] = _valorAluguelInicial;
        }
    }

    modifier onlyValidNumber(uint256 _number, string memory _descricao) {
        require(_number > 0, string.concat(_descricao, " invalido !"));
        _;
    }

    modifier onlyValidString(string memory _value, string memory _descricao) {
        require(
            keccak256(bytes(_value)) != keccak256(""),
            string.concat(_descricao, " invalido !")
        );
        _;
    }

    function showValorALuguelByMes(uint8 _mes)
        public
        view
        onlyValidNumber(_mes, "Mes")
        returns (uint256)
    {
        return contrato.valorAluguel36Meses[_mes - 1];
    }

    function showNomesDoLocadorELocatario()
        public
        view
        returns (string memory, string memory)
    {
        return (contrato.nomeLocador, contrato.nomeLocatario);
    }

    function setNameByType(uint8 _type, string calldata _valorNovoNome)
        public
        onlyOwner()
        onlyValidString(_valorNovoNome, "Novo nome")
        makeHashId()
        returns (bool)
    {
        require(_type == 1 || _type == 2, "Type informado invalido!");
        if (_type == 1) {
            contrato.nomeLocador = _valorNovoNome;
        } else if (_type == 2) {
            contrato.nomeLocatario = _valorNovoNome;
        }
        return true;
    }

    function setReajusteAluguelAposMesInformado(
        uint8 _mesInformado,
        uint256 _valorReajuste
    )
        public
        onlyOwner()
        onlyValidNumber(_mesInformado, "Mes")
        onlyValidNumber(_valorReajuste, "Valor")
        returns (bool)
    {
        if (_mesInformado > 36) {
            revert("Mes informado nao esta no contrato");
        }

        uint8 i;
        for (i = _mesInformado; i < 36; i++) {
            contrato.valorAluguel36Meses[i] =
                contrato.valorAluguel36Meses[i] +
                _valorReajuste;
        }
        return true;
    }
}
