import 'package:flutter/material.dart';

void main() => runApp(const TipCalculatorApp());

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1E5BD8),
      ),
      home: const TipCalculatorScreen(),
    );
  }
}

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final TextEditingController _billController = TextEditingController();
  double _tipPercent = 10;

  double get _bill => double.tryParse(_billController.text) ?? 0;
  double get _tipAmount => _bill * _tipPercent / 100;
  double get _total => _bill + _tipAmount;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF0FB),
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _billController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Bill amount',
                    prefixText: '\u20B9 ',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 24),
                Text(
                  'Tip: ${_tipPercent.round()}%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Slider(
                  value: _tipPercent,
                  min: 0,
                  max: 30,
                  divisions: 30,
                  label: '${_tipPercent.round()}%',
                  onChanged: (value) => setState(() => _tipPercent = value),
                ),
                const Divider(height: 32),
                _resultRow('Tip amount', _tipAmount),
                const SizedBox(height: 8),
                _resultRow('Total', _total, bold: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, double value, {bool bold = false}) {
    final style = TextStyle(
      fontSize: bold ? 22 : 18,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\u20B9 ${value.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
