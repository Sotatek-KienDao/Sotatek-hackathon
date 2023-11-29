import "@nomicfoundation/hardhat-toolbox";
import "hardhat-contract-sizer";
import "hardhat-gas-reporter";
import dotenv from "dotenv";
dotenv.config();

const privateKey = process.env.PRIVATE_KEY;
const infuraKey = process.env.INFURA_KEY;
const bscApiKey = process.env.BSC_API_KEY;
const avalancheApiKey = process.env.AVALANCHE_API_KEY;


export const solidity = {
  version: "0.6.12",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200,
    },
  },
};
export const networks = {
  hardhat: {
    gas: 12000000,
    blockGasLimit: 0x1fffffffffffff,
    allowUnlimitedContractSize: true,
    forking: {
      url: `https://goerli.infura.io/v3/${infuraKey}`,
    },
  },
  fuji: {
    chainId: 43113,
    url: "https://avalanche-fuji.rpc.thirdweb.com",
    accounts: [privateKey],
    timeout: 20000,
  },
  tbsc: {
    chainId: 97,
    url: "https://data-seed-prebsc-2-s2.binance.org:8545/",
    accounts: [privateKey],
    timeout: 20000,
  },
};
export const gasReporter = {
  enabled: process.env.REPORT_GAS !== undefined,
  currency: "USD",
};
export const etherscan = {
  apiKey: { fuji: avalancheApiKey, tbsc: bscApiKey }
};
export const mocha = {
  timeout: 50000,
};
export const contractSizer = {
  alphaSort: true,
  runOnCompile: true,
  disambiguatePaths: false,
};
