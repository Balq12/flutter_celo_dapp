import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

const abiDirectory = 'lib/services/celo.abi.json';

class Celo {
  late Web3Client _client;

  Celo() {
    Client httpClient = Client();
    _client =
        Web3Client('https://alfajores-forno.celo-testnet.org', httpClient);
  }

  final EthereumAddress _contractAddress =
      EthereumAddress.fromHex('<paste-the-contract-address-here>');
  final credentials = EthPrivateKey.fromHex('<paste-your-private-key-here>');

  Future<String> readGreet() async {
    final contractABI = await rootBundle.loadString(abiDirectory);
    final contract = DeployedContract(
        ContractAbi.fromJson(contractABI, "HelloWorld"), _contractAddress);
    final function = contract.function('getGreet');

    final response = await _client.call(
      contract: contract,
      function: function,
      params: [],
    );

    return response[0].toString();
  }

  Future<String> writeGreet(String message) async {
    final contractABI = await rootBundle.loadString(abiDirectory);
    final contract = DeployedContract(
        ContractAbi.fromJson(contractABI, "HelloWorld"), _contractAddress);
    final function = contract.function('setGreet');

    final response = await _client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [message],
      ),
      chainId: 44787,
    );

    return response;
  }
}
