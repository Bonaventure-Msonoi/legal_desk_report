// screens/civil_criminal_types.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'summary.dart'; // Import the SummaryScreen

class CivilCriminalTypesPage extends StatefulWidget {
  const CivilCriminalTypesPage({super.key});

  @override
  _CivilCriminalTypesPageState createState() => _CivilCriminalTypesPageState();
}

class _CivilCriminalTypesPageState extends State<CivilCriminalTypesPage> {
  // Define controllers for each input field
  final TextEditingController civilCasesController = TextEditingController();
  final TextEditingController criminalCasesController = TextEditingController();
  final TextEditingController otherCivilDescriptionController = TextEditingController();
  final TextEditingController otherCriminalDescriptionController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers to free resources
    civilCasesController.dispose();
    criminalCasesController.dispose();
    otherCivilDescriptionController.dispose();
    otherCriminalDescriptionController.dispose();
    super.dispose();
  }

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
            _buildOtherCaseTypeInput(otherCivilDescriptionController),
            _buildTotalNumberInput(civilCasesController, 'Total Number of Civil Cases'),
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
            _buildOtherCaseTypeInput(otherCriminalDescriptionController, 'Other Type of Criminal Matters'),
            _buildTotalNumberInput(criminalCasesController, 'Total Number of Clients with Criminal Cases'),
            _buildTotalNumberInput(criminalCasesController, 'Total Number of Clients'),

            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                  elevation: 8,
                ),
                onPressed: () async {
                  await _saveData(); // Save data
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SummaryScreen()), // Navigate to SummaryScreen
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
  Widget _buildOtherCaseTypeInput(TextEditingController controller, [String label = 'Other Type of Civil Case']) {
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
              controller: controller,
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
  Widget _buildTotalNumberInput(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
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

  // Method to save data
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save relevant data here
    await prefs.setString('total_civil_cases', civilCasesController.text);
    await prefs.setString('total_criminal_cases', criminalCasesController.text);
    await prefs.setString('other_civil_cases_description', otherCivilDescriptionController.text);
    await prefs.setString('other_criminal_cases_description', otherCriminalDescriptionController.text);
  }
}
