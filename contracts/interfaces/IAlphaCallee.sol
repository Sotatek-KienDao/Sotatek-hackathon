// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0;

interface IAlphaCallee {
    function alphaCall(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external;
}
