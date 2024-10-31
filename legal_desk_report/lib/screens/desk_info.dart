import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary.dart'; // Make sure to import the SummaryScreen

class DeskInfoPage extends StatefulWidget {
  const DeskInfoPage({super.key});

  @override
  _DeskInfoPageState createState() => _DeskInfoPageState();
}

class _DeskInfoPageState extends State<DeskInfoPage> {
  // Define controllers for the text fields
  final TextEditingController monthYearController = TextEditingController();
  final TextEditingController organisationController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController deskTypeController = TextEditingController();
  final TextEditingController deskNameController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    monthYearController.dispose();
    organisationController.dispose();
    provinceController.dispose();
    deskTypeController.dispose();
    deskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desk Information'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Input Field for Month and Year
                  _buildInputField(
                    controller: monthYearController,
                    label: 'Month and Year of Report',
                    hintText: 'Enter month and year (e.g. October 2024)',
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: organisationController,
                    label: 'CSO/Implementing Organisation',
                    hintText: 'Enter organisation name',
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: provinceController,
                    label: 'Desk Location (Province)',
                    hintText: 'Enter province location',
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: deskTypeController,
                    label: 'Type of Desk',
                    hintText: 'Specify type of desk',
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: deskNameController,
                    label: 'Name of Desk',
                    hintText: 'Enter name of desk',
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.deepPurpleAccent,
                        elevation: 8,
                      ),
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // Store data
                        await prefs.setString('report_month_year', monthYearController.text);
                        await prefs.setString('organisation_name', organisationController.text);
                        await prefs.setString('province_location', provinceController.text);
                        await prefs.setString('desk_type', deskTypeController.text);
                        await prefs.setString('desk_name', deskNameController.text);
                        
                        // Navigate to summary page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SummaryScreen()),
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
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller, // Attach the controller here
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
