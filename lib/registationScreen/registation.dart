
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:test/loginScreen/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  Future<void> registerUser() async {
    final url = Uri.parse("https://ecom.testpentas.in/api/v4/auth/register");

    final response = await http.post(
      url,
      body: {
        "f_name": firstNameController.text,
        "l_name": lastNameController.text,
        "email": usernameController.text,
        "phone": dobController.text,
        "password": genderController.text
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      print(response.body);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
      final snackbar = SnackBar(content: Text("Registration successful"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _TokenShow(context,response.body);
      firstNameController.clear();
      lastNameController.clear();
      usernameController.clear();
      dobController.clear();
      genderController.clear();
    } else {
      print(" failed. Error code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                "Create an account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'First Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: dobController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  registerUser();
                },
                child: Text('Register'),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign in',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

 void _TokenShow(BuildContext context , String token) {
    // Show a dialog with company information
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Token'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(token,style: TextStyle(fontSize: 10),),
              
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
