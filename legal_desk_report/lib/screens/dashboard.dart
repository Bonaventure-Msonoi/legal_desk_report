// screens/dashboard.dart

import 'package:flutter/material.dart';
import 'desk_info.dart';
import 'beneficiary.dart';
import 'civil_criminal_types.dart';
import 'service_type_provided.dart';
import 'outcome_type_waivers.dart';
import 'awareness_activities.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        children: const [
          Center(
            child: Text(
              'Dashboard Screen on the low',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          DeskInfoPage(), // Swipable Desk Info Page
          BeneficiariesPage(),
          CivilCriminalTypesPage(),
          ServiceTypeProvidedPage(),
          OutcomeTypeWaiversPage(),
          AwarenessActivitiesPage(),
        ],
      ),
    );
  }
}
