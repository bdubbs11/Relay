import 'package:flutter/material.dart';
import 'package:relay/components/button.dart';
import '../colors/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  String _username = "Dev";

  void changeUser() async{
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: Text(
              "Change the User",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Settings Page")
      ),
      body: const SafeArea(
        child: Center(    
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
                children:[
                  Text(
                    'Profile',
                    style: TextStyle(
                    color: AppColors.grayBlue,
                    fontSize: 30,
                    ),
                  )
                ]
              ),

              const SizedBox(height: 15),

              Row(
                children:[
                  Text(
                    'Username',
                    style: TextStyle(
                    color: AppColors.grayBlue,
                    fontSize: 20,
                    ),
                  )
                ]
              
                
              
              ),

              const SizedBox(height: 15),

              Row(
                children:[
                  Text(
                    'Bio',
                    style: TextStyle(
                    color: AppColors.grayBlue,
                    fontSize: 20,
                    ),
                  )
                ]

              ),

              const SizedBox(height: 15),

              Row(

                children:[
                  Text(
                    'Picture',
                    style: TextStyle(
                    color: AppColors.grayBlue,
                    fontSize: 20,
                    ),
                  )
                ]
              ),

              const SizedBox(height: 15),

              Row(
                children:[
                  Text(
                    'Settings',
                    style: TextStyle(
                    color: AppColors.grayBlue,
                    fontSize: 30,
                    ),
                  )
                ]
              ),

              const SizedBox(height: 15),

            ]
          
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}



