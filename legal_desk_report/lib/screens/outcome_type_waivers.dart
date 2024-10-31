// screens/outcome_type_waivers.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'summary.dart'; // Import the SummaryScreen

class OutcomeTypeWaiversPage extends StatefulWidget {
  const OutcomeTypeWaiversPage({super.key});

  @override
  _OutcomeTypeWaiversPageState createState() => _OutcomeTypeWaiversPageState();
}

class _OutcomeTypeWaiversPageState extends State<OutcomeTypeWaiversPage> {
  // Controllers for input fields
  final TextEditingController waivedCasesController = TextEditingController();
  final List<TextEditingController> outcomeControllers = List.generate(9, (_) => TextEditingController());
  final TextEditingController otherOutcomeCasesController = TextEditingController();
  final TextEditingController otherOutcomeDescriptionController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers to free resources
    waivedCasesController.dispose();
    for (var controller in outcomeControllers) {
      controller.dispose();
    }
    otherOutcomeCasesController.dispose();
    otherOutcomeDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of Outcomes and Number of Waivers'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Types of Outcomes and Number of Waivers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Section for Waived Contribution Fees
            _buildWaiverInput(
              'Number of Cases where Contribution Fees have been Waived (either partially or fully)',
              waivedCasesController,
            ),

            const SizedBox(height: 20),

            // Subheader for Type of Outcomes
            const Text(
              'Type of Outcomes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Outcome Input Fields
            _buildOutcomeInput('Cases Withdrawn', outcomeControllers[0]),
            _buildOutcomeInput('Division', outcomeControllers[1]),
            _buildOutcomeInput('Acquittals', outcomeControllers[2]),
            _buildOutcomeInput('Discharged', outcomeControllers[3]),
            _buildOutcomeInput('Juveniles ordered to go to reformatory/approved school', outcomeControllers[4]),
            _buildOutcomeInput('Convicted and Sentenced to a Fine', outcomeControllers[5]),
            _buildOutcomeInput('Convicted and Suspended Sentence', outcomeControllers[6]),
            _buildOutcomeInput('Convicted and Sentenced to Prison', outcomeControllers[7]),
            _buildOutcomeInput('Convicted and Sent to High Court for Sentencing/Confirmation', outcomeControllers[8]),

            // "Other (Specify)" Outcome Field
            _buildOtherOutcomeInput('Other (Specify)', otherOutcomeCasesController, otherOutcomeDescriptionController),

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

  // Method to create input fields for waiver-related cases
  Widget _buildWaiverInput(String label, TextEditingController controller) {
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

            // Input field for number of waived cases
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Number of Waived Cases',
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

  // Method to create input fields for each outcome type
  Widget _buildOutcomeInput(String label, TextEditingController controller) {
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

            // Input field for outcome cases
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Number of Cases',
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

  // Method to create input fields for the "Other (Specify)" outcome
  Widget _buildOtherOutcomeInput(String label, TextEditingController casesController, TextEditingController descriptionController) {
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

            // Input field for other outcome cases
            TextFormField(
              controller: casesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Number of Cases',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Input field for specifying other outcome
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
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

  // Method to save data
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save relevant data here
    await prefs.setString('waived_cases', waivedCasesController.text);
    for (int i = 0; i < outcomeControllers.length; i++) {
      await prefs.setString('outcome_${i + 1}', outcomeControllers[i].text);
    }
    await prefs.setString('other_outcome_cases', otherOutcomeCasesController.text);
    await prefs.setString('other_outcome_description', otherOutcomeDescriptionController.text);
  }
}
