import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyProfilePage(title: 'My Profile Page'),
      
    );
  }
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Column(
              children: [
                const Card(
                  
                  
                  child: Text("Your big backed mama")),
              ],
            ),
            Text(
              style: Theme.of(context).textTheme.headlineLarge,
              'Big Card with Profile Picture Goes Here',
            ),
            const NameSection(),
            const BioSection(),
            
          ],
        ),
      ),
    );
  }
}

class BioSection extends StatefulWidget {
  const BioSection({super.key});

  @override
  State<BioSection> createState() => _BioSectionState();
}

class _BioSectionState extends State<BioSection> {
  String bio = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(5), 
        alignment: Alignment.center,
        child: const Text('Nobody talk to me! I hate everyone!'
        ),
      ),
    ],
    );
  }
}

class NameSection extends StatefulWidget {
  const NameSection({super.key});

  @override
  State<NameSection> createState() => _NameSectionState();
}

class _NameSectionState extends State<NameSection> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(5), 
        alignment: Alignment.center,
        child: const Text('all lowercase name'),
      ),
    ],
    );
  }
}
