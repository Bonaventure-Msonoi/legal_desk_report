import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary.dart'; // Make sure to import the SummaryScreen
import 'beneficiary.dart';
class DeskInfoPage extends StatefulWidget {
  const DeskInfoPage({super.key});

  @override
  _DeskInfoPageState createState() => _DeskInfoPageState();
}

class _DeskInfoPageState extends State<DeskInfoPage> {
  // Define controllers for the text fields
  final TextEditingController monthYearController = TextEditingController();
  final TextEditingController deskNameController = TextEditingController();

  // Define variables to store selected values
  String? selectedProvince;
  String? selectedDeskType;
  String? selectedOrganisation;

  // Define a variable to store the selected date
  DateTime? selectedDate;

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    monthYearController.dispose();
    deskNameController.dispose();
    super.dispose();
  }

  // Function to open the date picker and set the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Display the selected date in the controller
        monthYearController.text = '${picked.month}/${picked.year}';
      });
    }
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
                  // New Input Field for Date of Report with Date Picker
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Month and Year of Report',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: monthYearController,
                            decoration: InputDecoration(
                              hintText: 'Select date (e.g. 10/2024)',
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Dropdown for Implementing Organisation
                  _buildDropdownField(
                    label: 'CSO/Implementing Organisation',
                    value: selectedOrganisation,
                    items: [
                      'YWCA branches',
                      'NLACW',
                      'NRF',
                      'PFF',
                      'Catholic dioceses Caritas',
                      'UpZambia',
                      'PRISCCA',
                      'Legal Aid Board and PRISCCA'
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedOrganisation = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Dropdown for Desk Location (Province)
                  _buildDropdownField(
                    label: 'Desk Location (Province)',
                    value: selectedProvince,
                    items: [
                      'Lusaka',
                      'Copperbelt',
                      'Central',
                      'Luapula',
                      'Southern'
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Dropdown for Type of Desk
                  _buildDropdownField(
                    label: 'Type of Desk',
                    value: selectedDeskType,
                    items: [
                      'Community Legal Desk',
                      'Correctional Facility Legal Desk',
                      'Legal Services Unit',
                      'Police Station Legal Desk'
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedDeskType = value;
                      });
                    },
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
                        await prefs.setString('organisation_name', selectedOrganisation ?? '');
                        await prefs.setString('province_location', selectedProvince ?? '');
                        await prefs.setString('desk_type', selectedDeskType ?? '');
                        await prefs.setString('desk_name', deskNameController.text);
                        
                        // Navigate to summary page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BeneficiariesPage()),
                        );
                      },
                      child: const Text(
                        'next',
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

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
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
