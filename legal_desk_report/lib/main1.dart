// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = '';

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('name', _name);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Data Saved!')),
//       );
//     }
//   }

//   void _navigateToViewData() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ViewDataPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Enter your name'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter some text';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _name = value!;
//                     },
//                   ),
//                   ElevatedButton(
//                     onPressed: _submitForm,
//                     child: const Text('Submit'),
//                   ),
//                   ElevatedButton(
//                     onPressed: _navigateToViewData,
//                     child: const Text('View Submitted Data'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ViewDataPage extends StatelessWidget {
//   const ViewDataPage({super.key});

//   Future<String?> _getName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('name');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Submitted Data'),
//       ),
//       body: FutureBuilder<String?>(
//         future: _getName(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error retrieving data'));
//           } else {
//             return Center(
//               child: Text(
//                 snapshot.data != null ? 'Submitted Name: ${snapshot.data}' : 'No data submitted',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
