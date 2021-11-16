// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IVaultV2 {
    function deposit() external payable;
    function withdraw() external;
}

contract Depositor is Ownable {

    IVaultV2 public immutable vault;

    constructor(address vaultContractAddress) {
        vault = IVaultV2(vaultContractAddress);
    }

    function depositToVault() external payable onlyOwner {
        vault.deposit{value: msg.value}();
    }

    function withdrawFromVault() external onlyOwner {
        vault.withdraw();
    }

    function withdrawAll() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    receive() external payable {} // Recibe ethers de otros contratos
}
