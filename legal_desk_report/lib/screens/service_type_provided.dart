// screens/service_type_provided.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'summary.dart'; // Import the SummaryScreen
import 'outcome_type_waivers.dart';

class ServiceTypeProvidedPage extends StatefulWidget {
  const ServiceTypeProvidedPage({super.key});

  @override
  _ServiceTypeProvidedPageState createState() => _ServiceTypeProvidedPageState();
}

class _ServiceTypeProvidedPageState extends State<ServiceTypeProvidedPage> {
  // Controllers for input fields
  final TextEditingController inmateReleaseController = TextEditingController();
  final TextEditingController juvenileDiversionController = TextEditingController();
  final TextEditingController successfulMediationController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers to free resources
    inmateReleaseController.dispose();
    juvenileDiversionController.dispose();
    successfulMediationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of Services Provided'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Types of Services Provided by Paralegals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildServiceProvidedInput(
              'Inmate or persons in police custody successfully released on police bond or bail following LSU or legal desk\'s assistance',
              inmateReleaseController,
            ),
            _buildServiceProvidedInput(
              'Juveniles sent for diversion following LSU or legal desk\'s assistance',
              juvenileDiversionController,
            ),
            _buildServiceProvidedInput(
              'Successful mediation (in civil cases)',
              successfulMediationController,
            ),

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
                    MaterialPageRoute(builder: (context) => const OutcomeTypeWaiversPage()), // Navigate to SummaryScreen
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create input fields for each service type
  Widget _buildServiceProvidedInput(String label, TextEditingController controller) {
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

            // Input field for number of clients
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Number of Clients Receiving Service',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Input field for comments on service provided
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Comments on Service Provided',
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

  // Method to save data
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save relevant data here
    await prefs.setString('inmate_release', inmateReleaseController.text);
    await prefs.setString('juvenile_diversion', juvenileDiversionController.text);
    await prefs.setString('successful_mediation', successfulMediationController.text);
  }
}
