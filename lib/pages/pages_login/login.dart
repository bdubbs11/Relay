import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../colors/colors.dart';
import '../../components/textfield.dart';
import '../../components/button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Method to show dialog box to get user's email
  Future<void> promptEmail() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Forgot Password'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Enter your email'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              forgotPassword(emailController.text);
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }

  // Method to send password reset email
  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent to $email'),
          duration: Duration(seconds: 5),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }


// sign user in
void signUserIn() async{

  // show loading circle 
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
  );

  // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
  }
}

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/blackLogo.png"),
                    fit: BoxFit.contain, // Adjust this based on your image's aspect ratio
                  ),
                ),
              ),

              const SizedBox(height: 50), 
              // Login text
              // optional logo or something around here
              const Text(
                'Login',
                style: TextStyle(
                  color: AppColors.lightBrown,
                  fontSize: 50,
                ),
              ),

              const SizedBox(height: 10), 

              // email field / alternatively can do username field
              MyTextField(
                controller: emailController,
                hintText: "Email", 
                obscureText: false,
              ),

              const SizedBox(height: 10), 

              // password field

              MyTextField(
                controller: passwordController,
                hintText: "Password", 
                obscureText: true,
              ),

              const SizedBox(height: 10), 

              // forgot password
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      GestureDetector(
                        onTap: () {
                          promptEmail();
                        },
                        child: 
                        Text(
                          'Forgot Password?',
                          //style: TextStyle(color: AppColors.cloudBlue),
                          style: TextStyle(color: AppColors.lightBrown),
                        ),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 20), 

                // sign in button
                Button(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),

                const SizedBox(height: 200),
                // or continue with i am not adding this unless we discuss something else



              // line above the sign up
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.cloudBlue,
                    
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              // not a member create an account 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      //style: TextStyle(color: AppColors.cloudBlue),
                      style: TextStyle(color: AppColors.lightBrown),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: 
                      const Text(
                        'Sign up',
                        style :TextStyle(
                          //color: AppColors.skyBlue,
                          color: AppColors.lightBrown,
                          fontWeight: FontWeight.bold,
                        ),
                        
                      ),

                    ),
                  ],
                ),
                const SizedBox(height: 20),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}