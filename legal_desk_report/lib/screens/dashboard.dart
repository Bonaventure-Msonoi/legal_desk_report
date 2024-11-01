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
        children: [
          // Initial Cute "Under Construction" Page
          Container(
            color: Colors.purple.shade50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Construction Icon
                  Icon(
                    Icons.construction,
                    size: 100,
                    color: Colors.deepPurpleAccent.shade100,
                  ),
                  const SizedBox(height: 20),
                  
                  // Dashboard Message
                  Text(
                    'Dashboard Under Construction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  
                  // Swipe Instructions
                  const SizedBox(height: 15),
                  Text(
                    'Swipe right to explore more!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent.shade700,
                    ),
                  ),
                  
                  // Swiping Arrow
                  const SizedBox(height: 30),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 40,
                    color: Colors.deepPurpleAccent.shade100,
                  ),
                ],
              ),
            ),
          ),

          // Other Pages
          const DeskInfoPage(),
          const BeneficiariesPage(),
          const CivilCriminalTypesPage(),
          const ServiceTypeProvidedPage(),
          const OutcomeTypeWaiversPage(),
          const AwarenessActivitiesPage(),
        ],
      ),
    );
  }
}
