import 'package:flutter/material.dart';
import 'text_input_formatter.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  TipCalculatorState createState() => TipCalculatorState();
}

class TipCalculatorState extends State<TipCalculator> {
  final TextEditingController totalController = TextEditingController();
  final amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,2})?\$');

  double subTotal = 0.0;
  double tipValue = 0.0;
  double tipPercentage = 0.0;
  double tipAmount = 0.0;
  double totalWithTip = 0.0;

  void calculateTip() {
    final double total = double.tryParse(totalController.text) ?? 0.0;
    final double tip = total * (tipValue / 100);
    setState(() {
      subTotal = total;
      tipAmount = tip;
      tipPercentage = tipValue;
      totalWithTip = total + tip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Propinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: totalController,
              inputFormatters: [amountValidator],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              decoration: const InputDecoration(
                labelText: 'Total de la Cuenta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Text('Porcentaje de Propina:'),
                Expanded(
                  child: Slider(
                    value: tipValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${tipValue.toStringAsFixed(2)}%',
                    onChanged: (double newValue) {
                      setState(() {
                        tipValue = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateTip,
              child: const Text('Calcular Propina'),
            ),
            const SizedBox(height: 20),
            Text(
              'Sub Total: \$${subTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Propina (Porcentaje): ${tipPercentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Propina (En pesos): \$${tipAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Total: \$${totalWithTip.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}