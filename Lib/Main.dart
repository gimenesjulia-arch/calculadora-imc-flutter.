import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = '';

  void _calcularIMC() {
    double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
    double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));

    if (peso == null || altura == null || altura == 0) {
      setState(() {
        _resultado = 'Informe valores válidos!';
      });
      return;
    }

    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 18.5) {
        _resultado = 'IMC: ${imc.toStringAsFixed(2)} - Abaixo do peso';
      } else if (imc < 25) {
        _resultado = 'IMC: ${imc.toStringAsFixed(2)} - Peso normal';
      } else if (imc < 30) {
        _resultado = 'IMC: ${imc.toStringAsFixed(2)} - Sobrepeso';
      } else {
        _resultado = 'IMC: ${imc.toStringAsFixed(2)} - Obesidade';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 20),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
