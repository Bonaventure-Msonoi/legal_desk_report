// screens/civil_criminal_types.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CivilCriminalTypesPage extends StatelessWidget {
  const CivilCriminalTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civil and Criminal Types'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Civil Cases Section
            const Text(
              'Type of Case: Civil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildCaseTypeInput('Family/Matrimonial and Property Disputes'),
            _buildCaseTypeInput('Contract Related Disputes'),
            _buildCaseTypeInput('Labour and Employment Disputes'),
            _buildCaseTypeInput('Land Disputes'),
            _buildCaseTypeInput('Torts'),
            _buildCaseTypeInput('Disability Right Issues'),
            _buildOtherCaseTypeInput(),
            _buildTotalNumberInput('Total Number of Civil Cases'),
            const SizedBox(height: 40),

            // Criminal Cases Section
            const Text(
              'Type of Case: Criminal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildCaseTypeInput('Offences Unrelated to GBV'),
            _buildCaseTypeInput('Offences Against the Person Unrelated to GBV'),
            _buildCaseTypeInput('Offences Against Property'),
            _buildCaseTypeInput('Road Traffic Offences'),
            _buildCaseTypeInput('Drug Abuse and Trafficking Offences'),
            _buildCaseTypeInput('Wildlife Related Offences'),
            _buildCaseTypeInput('Immigration Related Offences'),
            _buildCaseTypeInput('Offenses Against Public Order'),
            _buildOtherCaseTypeInput('Other Type of Criminal Matters'),
            _buildTotalNumberInput('Total Number of Clients with Criminal Cases'),
            _buildTotalNumberInput('Total Number of Clients'),
          ],
        ),
      ),
    );
  }

  // Method to create input fields for each case type
  Widget _buildCaseTypeInput(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Number of Clients',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create input fields for "Other types" with additional brief field
  Widget _buildOtherCaseTypeInput([String label = 'Other Type of Civil Case']) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Number of Clients',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Brief Description',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create total number input fields
  Widget _buildTotalNumberInput(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
