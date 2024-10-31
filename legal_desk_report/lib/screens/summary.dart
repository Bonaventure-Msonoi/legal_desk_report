import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart'; // Import the pdf package
import 'package:pdf/widgets.dart' as pw; // Import the pdf widgets

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String reportMonthYear = '';
  String organisationName = '';
  String provinceLocation = '';
  String deskType = '';
  String deskName = '';

  String civilAdultMaleClients = '';
  String civilAdultMaleDisabilities = '';
  String civilAdultFemaleClients = '';
  String civilAdultFemaleDisabilities = '';
  String criminalAdultMaleClients = '';
  String criminalAdultMaleDisabilities = '';
  String criminalAdultFemaleClients = '';
  String criminalAdultFemaleDisabilities = '';

  String totalCivilCases = '';
  String totalCriminalCases = '';
  String otherCivilCasesDescription = '';
  String otherCriminalCasesDescription = '';

  String inmateRelease = '';
  String juvenileDiversion = '';
  String successfulMediation = '';

  String waivedCases = '';
  List<String> outcomes = List.filled(9, ''); // Assuming 9 outcomes
  String otherOutcomeCases = '';
  String otherOutcomeDescription = '';

  List<Map<String, dynamic>> activities = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Load Desk Info
      reportMonthYear = prefs.getString('report_month_year') ?? '';
      organisationName = prefs.getString('organisation_name') ?? '';
      provinceLocation = prefs.getString('province_location') ?? '';
      deskType = prefs.getString('desk_type') ?? '';
      deskName = prefs.getString('desk_name') ?? '';

      // Load Beneficiary Info
      civilAdultMaleClients = prefs.getString('civil_adult_male_clients') ?? '';
      civilAdultMaleDisabilities = prefs.getString('civil_adult_male_disabilities') ?? '';
      civilAdultFemaleClients = prefs.getString('civil_adult_female_clients') ?? '';
      civilAdultFemaleDisabilities = prefs.getString('civil_adult_female_disabilities') ?? '';
      criminalAdultMaleClients = prefs.getString('criminal_adult_male_clients') ?? '';
      criminalAdultMaleDisabilities = prefs.getString('criminal_adult_male_disabilities') ?? '';
      criminalAdultFemaleClients = prefs.getString('criminal_adult_female_clients') ?? '';
      criminalAdultFemaleDisabilities = prefs.getString('criminal_adult_female_disabilities') ?? '';

      // Load Civil and Criminal Case Types
      totalCivilCases = prefs.getString('total_civil_cases') ?? '';
      totalCriminalCases = prefs.getString('total_criminal_cases') ?? '';
      otherCivilCasesDescription = prefs.getString('other_civil_cases_description') ?? '';
      otherCriminalCasesDescription = prefs.getString('other_criminal_cases_description') ?? '';

      // Load Service Type Provided Info
      inmateRelease = prefs.getString('inmate_release') ?? '';
      juvenileDiversion = prefs.getString('juvenile_diversion') ?? '';
      successfulMediation = prefs.getString('successful_mediation') ?? '';

      // Load Outcome Type Waivers Info
      waivedCases = prefs.getString('waived_cases') ?? '';
      outcomes[0] = prefs.getString('outcome_1') ?? ''; // Cases Withdrawn
      outcomes[1] = prefs.getString('outcome_2') ?? ''; // Division
      outcomes[2] = prefs.getString('outcome_3') ?? ''; // Acquittals
      outcomes[3] = prefs.getString('outcome_4') ?? ''; // Discharged
      outcomes[4] = prefs.getString('outcome_5') ?? ''; // Juveniles ordered to go to reformatory/approved school
      outcomes[5] = prefs.getString('outcome_6') ?? ''; // Convicted and Sentenced to a Fine
      outcomes[6] = prefs.getString('outcome_7') ?? ''; // Convicted and Suspended Sentence
      outcomes[7] = prefs.getString('outcome_8') ?? ''; // Convicted and Sentenced to Prison
      outcomes[8] = prefs.getString('outcome_9') ?? ''; // Convicted and Sent to High Court for Sentencing/Confirmation
      otherOutcomeCases = prefs.getString('other_outcome_cases') ?? '';
      otherOutcomeDescription = prefs.getString('other_outcome_description') ?? '';

      // Load Awareness Activities Info
      int activityCount = 0;
      while (prefs.containsKey('activity_${activityCount}_date')) {
        activities.add({
          'date': prefs.getString('activity_${activityCount}_date'),
          'type': prefs.getString('activity_${activityCount}_type'),
          'topic': prefs.getString('activity_${activityCount}_topic'),
          'location': prefs.getString('activity_${activityCount}_location'),
          'men': prefs.getString('activity_${activityCount}_men'),
          'women': prefs.getString('activity_${activityCount}_women'),
          'maleChildren': prefs.getString('activity_${activityCount}_maleChildren'),
          'femaleChildren': prefs.getString('activity_${activityCount}_femaleChildren'),
          'totalParticipants': prefs.getString('activity_${activityCount}_totalParticipants'),
        });
        activityCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Desk Information'),
            _buildSummaryTile('Month and Year of Report', reportMonthYear),
            _buildSummaryTile('CSO/Implementing Organisation', organisationName),
            _buildSummaryTile('Desk Location (Province)', provinceLocation),
            _buildSummaryTile('Type of Desk', deskType),
            _buildSummaryTile('Name of Desk', deskName),

            const SizedBox(height: 20),
            _buildSectionTitle('Beneficiaries - Civil'),
            _buildSummaryTile('Adult Male Clients', civilAdultMaleClients),
            _buildSummaryTile('Adult Male Clients with Disabilities', civilAdultMaleDisabilities),
            _buildSummaryTile('Adult Female Clients', civilAdultFemaleClients),
            _buildSummaryTile('Adult Female Clients with Disabilities', civilAdultFemaleDisabilities),

            const SizedBox(height: 20),
            _buildSectionTitle('Beneficiaries - Criminal'),
            _buildSummaryTile('Adult Male Clients', criminalAdultMaleClients),
            _buildSummaryTile('Adult Male Clients with Disabilities', criminalAdultMaleDisabilities),
            _buildSummaryTile('Adult Female Clients', criminalAdultFemaleClients),
            _buildSummaryTile('Adult Female Clients with Disabilities', criminalAdultFemaleDisabilities),

            const SizedBox(height: 20),
            _buildSectionTitle('Civil and Criminal Cases'),
            _buildSummaryTile('Total Number of Civil Cases', totalCivilCases),
            _buildSummaryTile('Total Number of Criminal Cases', totalCriminalCases),
            _buildSummaryTile('Other Civil Cases Description', otherCivilCasesDescription),
            _buildSummaryTile('Other Criminal Cases Description', otherCriminalCasesDescription),

            const SizedBox(height: 20),
            _buildSectionTitle('Services Provided'),
            _buildSummaryTile('Inmate Release', inmateRelease),
            _buildSummaryTile('Juvenile Diversion', juvenileDiversion),
            _buildSummaryTile('Successful Mediation', successfulMediation),

            const SizedBox(height: 20),
            _buildSectionTitle('Outcome Type Waivers'),
            _buildSummaryTile('Number of Waived Cases', waivedCases),
            _buildSummaryTile('Cases Withdrawn', outcomes[0]),
            _buildSummaryTile('Division', outcomes[1]),
            _buildSummaryTile('Acquittals', outcomes[2]),
            _buildSummaryTile('Discharged', outcomes[3]),
            _buildSummaryTile('Juveniles ordered to go to reformatory/approved school', outcomes[4]),
            _buildSummaryTile('Convicted and Sentenced to a Fine', outcomes[5]),
            _buildSummaryTile('Convicted and Suspended Sentence', outcomes[6]),
            _buildSummaryTile('Convicted and Sentenced to Prison', outcomes[7]),
            _buildSummaryTile('Convicted and Sent to High Court for Sentencing/Confirmation', outcomes[8]),
            _buildSummaryTile('Other Outcome Cases', otherOutcomeCases),
            _buildSummaryTile('Other Outcome Description', otherOutcomeDescription),

            const SizedBox(height: 20),
            _buildSectionTitle('Awareness Activities'),
            for (var activity in activities)
              _buildSummaryTile('Activity Type: ${activity['type']}', 'Date: ${activity['date']}, Total Participants: ${activity['totalParticipants']}'),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAsPdf, // Call the method to save as PDF
              child: const Text('Save as PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAsPdf() async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Summary Report'), // Add your content here
          );
        },
      ),
    );

    // Save the PDF file (you may need to implement file saving logic here)
    // For example, using path_provider to get the directory and save the file
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
      ),
    );
  }

  Widget _buildSummaryTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
