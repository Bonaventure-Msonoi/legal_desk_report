// screens/service_type_provided.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceTypeProvidedPage extends StatelessWidget {
  const ServiceTypeProvidedPage({super.key});

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
            ),
            _buildServiceProvidedInput(
              'Juveniles sent for diversion following LSU or legal desk\'s assistance',
            ),
            _buildServiceProvidedInput(
              'Successful mediation (in civil cases)',
            ),
          ],
        ),
      ),
    );
  }

  // Method to create input fields for each service type
  Widget _buildServiceProvidedInput(String label) {
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
}