// screens/awareness_activities.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'summary.dart'; // Import the SummaryScreen

class AwarenessActivitiesPage extends StatefulWidget {
  const AwarenessActivitiesPage({super.key});

  @override
  _AwarenessActivitiesPageState createState() => _AwarenessActivitiesPageState();
}

class _AwarenessActivitiesPageState extends State<AwarenessActivitiesPage> {
  List<Map<String, dynamic>> activities = [];

  // Function to add a new activity
  void _addActivity() {
    setState(() {
      activities.add({
        'date': null,
        'type': '',
        'topic': '',
        'location': '',
        'men': '',
        'women': '',
        'maleChildren': '',
        'femaleChildren': '',
        'totalParticipants': '0', // Initialize to 0
      });
    });
  }

  // Function to select a date
  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        activities[index]['date'] = picked;
      });
    }
  }

  // Function to calculate total participants automatically
  void _calculateTotal(int index) {
    final int men = int.tryParse(activities[index]['men'] ?? '') ?? 0;
    final int women = int.tryParse(activities[index]['women'] ?? '') ?? 0;
    final int maleChildren = int.tryParse(activities[index]['maleChildren'] ?? '') ?? 0;
    final int femaleChildren = int.tryParse(activities[index]['femaleChildren'] ?? '') ?? 0;
    
    setState(() {
      activities[index]['totalParticipants'] = (men + women + maleChildren + femaleChildren).toString();
    });
  }

  // Method to save data
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < activities.length; i++) {
      await prefs.setString('activity_${i}_date', activities[i]['date']?.toString() ?? '');
      await prefs.setString('activity_${i}_type', activities[i]['type']);
      await prefs.setString('activity_${i}_topic', activities[i]['topic']);
      await prefs.setString('activity_${i}_location', activities[i]['location']);
      await prefs.setString('activity_${i}_men', activities[i]['men']);
      await prefs.setString('activity_${i}_women', activities[i]['women']);
      await prefs.setString('activity_${i}_maleChildren', activities[i]['maleChildren']);
      await prefs.setString('activity_${i}_femaleChildren', activities[i]['femaleChildren']);
      await prefs.setString('activity_${i}_totalParticipants', activities[i]['totalParticipants']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awareness Activities'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Awareness Raising Activities Conducted by Desk During the Period Under Review',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Button to add a new activity
            ElevatedButton(
              onPressed: _addActivity,
              child: const Text('Create Activity'),
            ),
            const SizedBox(height: 20),

            // List of dynamically added activity forms
            ...activities.asMap().entries.map((entry) {
              int index = entry.key;
              return _buildActivityForm(index);
            }).toList(),

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

  // Method to create each activity form
  Widget _buildActivityForm(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
          // Date Picker Field
          Row(
            children: [
              const Text('Date:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: () => _selectDate(context, index),
                  child: Text(
                    activities[index]['date'] == null
                        ? 'Select Date'
                        : '${activities[index]['date'].day}/${activities[index]['date'].month}/${activities[index]['date'].year}',
                  ),
                ),
              ),
            ],
          ),
          _buildTextInputField(index, 'type', 'Type of Activity'),
          _buildTextInputField(index, 'topic', 'Topic Covered'),
          _buildTextInputField(index, 'location', 'Location'),

          // Number of Men
          _buildNumericInputField(index, 'men', 'Number of Men'),

          // Number of Women
          _buildNumericInputField(index, 'women', 'Number of Women'),

          // Number of Male Children
          _buildNumericInputField(index, 'maleChildren', 'Number of Male Children'),

          // Number of Female Children
          _buildNumericInputField(index, 'femaleChildren', 'Number of Female Children'),

          // Total Participants (Auto-calculated)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Total Number of Participants: ${activities[index]['totalParticipants']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Generic text input field
  Widget _buildTextInputField(int index, String key, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onChanged: (value) => activities[index][key] = value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100], // Ensure this is not 'const'
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Numeric input field
  Widget _buildNumericInputField(int index, String key, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          activities[index][key] = value;
          _calculateTotal(index);
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100], // Ensure this is not 'const'
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
