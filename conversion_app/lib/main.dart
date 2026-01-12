import 'package:flutter/material.dart';

void main() {
  runApp(const ConversionApp());
}

class ConversionApp extends StatelessWidget {
  const ConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConversionHomePage(),
    );
  }
}

class ConversionHomePage extends StatefulWidget {
  const ConversionHomePage({super.key});

  @override
  State<ConversionHomePage> createState() => _ConversionHomePageState();
}

class _ConversionHomePageState extends State<ConversionHomePage> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  String _resultText = '';

  // Grouping units by type to allow only valid conversions
  final Map<String, List<String>> _unitGroups = {
    'length': ['meters', 'feet', 'kilometers', 'miles'],
    'weight': ['kilograms', 'pounds', 'ounces'],
    'volume': ['milliliters', 'liters'],
  };

  // Conversion factors to base unit (meters, kilograms, liters)
  final Map<String, double> _conversionToBase = {
    'meters': 1.0,
    'kilometers': 1000.0,
    'feet': 0.3048,
    'miles': 1609.34,
    'kilograms': 1.0,
    'pounds': 0.453592,
    'ounces': 0.0283495,
    'liters': 1.0,
    'milliliters': 0.001,
  };

  // Determine which group a unit belongs to
  String? _getGroup(String unit) {
    for (var entry in _unitGroups.entries) {
      if (entry.value.contains(unit)) return entry.key;
    }
    return null;
  }

  void _convert() {
    final inputText = _inputController.text;
    if (inputText.isEmpty) {
      setState(() {
        _resultText = 'Please enter a value';
      });
      return;
    }

    final inputValue = double.tryParse(inputText);
    if (inputValue == null) {
      setState(() {
        _resultText = 'Invalid number';
      });
      return;
    }

    // Check if units belong to same group
    final fromGroup = _getGroup(_fromUnit);
    final toGroup = _getGroup(_toUnit);

    if (fromGroup == null || toGroup == null || fromGroup != toGroup) {
      setState(() {
        _resultText = 'Cannot convert $_fromUnit to $_toUnit';
      });
      return;
    }

    // Convert via base unit
    final baseValue = inputValue * (_conversionToBase[_fromUnit] ?? 1.0);
    final convertedValue = baseValue / (_conversionToBase[_toUnit] ?? 1.0);

    setState(() {
      _resultText =
          '${inputValue.toStringAsFixed(2)} $_fromUnit is ${convertedValue.toStringAsFixed(2)} $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    // All units as dropdown options
    final allUnits = _conversionToBase.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Conversion App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Numeric input
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter value',
              ),
            ),
            const SizedBox(height: 20),

            // From & To dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // From
                DropdownButton<String>(
                  value: _fromUnit,
                  items: allUnits
                      .map((unit) =>
                          DropdownMenuItem(value: unit, child: Text(unit)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                      _convert();
                    });
                  },
                ),

                const Icon(Icons.arrow_forward, size: 30),

                // To
                DropdownButton<String>(
                  value: _toUnit,
                  items: allUnits
                      .map((unit) =>
                          DropdownMenuItem(value: unit, child: Text(unit)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                      _convert();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Convert button
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),

            const SizedBox(height: 30),

            // Result text
            Text(
              _resultText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
