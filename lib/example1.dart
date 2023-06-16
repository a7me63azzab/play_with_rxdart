// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:rxdart/rxdart.dart';

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
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends HookWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final subject = useMemoized(() => BehaviorSubject<String>(), [key]);

//     useEffect(() => subject.close, [subject]);

//     return Scaffold(
//       appBar: AppBar(
//         title: StreamBuilder<String>(
//             stream: subject.stream
//                 .distinct()
//                 .debounceTime(const Duration(seconds: 1)),
//             initialData: 'Please start typing ... ',
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text("${snapshot.data}");
//               } else {
//                 return const Text("Home Page");
//               }
//             }),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: TextField(
//             onChanged: subject.sink.add,
//           ),
//         ),
//       ),
//     );
//   }
// }
