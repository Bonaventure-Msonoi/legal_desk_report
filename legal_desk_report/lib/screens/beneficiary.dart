import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary.dart'; // Make sure to import the SummaryScreen
import 'civil_criminal_types.dart';
class BeneficiariesPage extends StatefulWidget {
  const BeneficiariesPage({Key? key}) : super(key: key);

  @override
  _BeneficiariesPageState createState() => _BeneficiariesPageState();
}

class _BeneficiariesPageState extends State<BeneficiariesPage> {
  // Define controllers for each text field
  final TextEditingController civilAdultMaleController = TextEditingController();
  final TextEditingController civilAdultMaleDisabilitiesController = TextEditingController();
  final TextEditingController civilAdultFemaleController = TextEditingController();
  final TextEditingController civilAdultFemaleDisabilitiesController = TextEditingController();
  final TextEditingController criminalAdultMaleController = TextEditingController();
  final TextEditingController criminalAdultMaleDisabilitiesController = TextEditingController();
  final TextEditingController criminalAdultFemaleController = TextEditingController();
  final TextEditingController criminalAdultFemaleDisabilitiesController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers to free resources
    civilAdultMaleController.dispose();
    civilAdultMaleDisabilitiesController.dispose();
    civilAdultFemaleController.dispose();
    civilAdultFemaleDisabilitiesController.dispose();
    criminalAdultMaleController.dispose();
    criminalAdultMaleDisabilitiesController.dispose();
    criminalAdultFemaleController.dispose();
    criminalAdultFemaleDisabilitiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beneficiaries'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection('Civil', civilAdultMaleController, civilAdultMaleDisabilitiesController, civilAdultFemaleController, civilAdultFemaleDisabilitiesController),
            const SizedBox(height: 30),
            _buildSection('Criminal', criminalAdultMaleController, criminalAdultMaleDisabilitiesController, criminalAdultFemaleController, criminalAdultFemaleDisabilitiesController),
            const SizedBox(height: 30),
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
                    MaterialPageRoute(builder: (context) => const CivilCriminalTypesPage()), // Navigate to SummaryScreen
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

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('civil_adult_male_clients', civilAdultMaleController.text);
    await prefs.setString('civil_adult_male_disabilities', civilAdultMaleDisabilitiesController.text);
    await prefs.setString('civil_adult_female_clients', civilAdultFemaleController.text);
    await prefs.setString('civil_adult_female_disabilities', civilAdultFemaleDisabilitiesController.text);
    await prefs.setString('criminal_adult_male_clients', criminalAdultMaleController.text);
    await prefs.setString('criminal_adult_male_disabilities', criminalAdultMaleDisabilitiesController.text);
    await prefs.setString('criminal_adult_female_clients', criminalAdultFemaleController.text);
    await prefs.setString('criminal_adult_female_disabilities', criminalAdultFemaleDisabilitiesController.text);
  }

  Widget _buildSection(
    String caseType,
    TextEditingController maleController,
    TextEditingController maleDisabilitiesController,
    TextEditingController femaleController,
    TextEditingController femaleDisabilitiesController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type of Case: $caseType',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildGenderSection('$caseType - Adult Male', maleController, maleDisabilitiesController),
        const SizedBox(height: 20),
        _buildGenderSection('$caseType - Adult Female', femaleController, femaleDisabilitiesController),
      ],
    );
  }

  Widget _buildGenderSection(
    String label,
    TextEditingController clientsController,
    TextEditingController disabilitiesController,
  ) {
    return Container(
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
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          TextFormField(
            controller: clientsController,
            decoration: const InputDecoration(
              labelText: 'Number of Clients',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: disabilitiesController,
            decoration: const InputDecoration(
              labelText: 'Number of Clients with Disabilities',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
} 