import 'package:celo_flutter_dapp/services/celo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _greetController = TextEditingController();
  final _celo = Celo();

  @override
  void initState() {
    super.initState();
    _updateGreetMessage();
  }

  void _updateGreetMessage() async {
    final message = await _celo.readGreet();
    setState(() {
      _greetController.text = message;
    });
  }

  void _changeGreetMessage() async {
    await _celo.writeGreet(_greetController.text);
    _updateGreetMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celo Flutter Dapp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _greetController,
              decoration: const InputDecoration(
                labelText: 'Greet Message',
              ),
            ),
            ElevatedButton(
              onPressed: _changeGreetMessage,
              child: const Text('Change Greet Message'),
            ),
          ],
        ),
      ),
    );
  }
}
