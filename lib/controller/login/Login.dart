import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:kaar/controller/home/HomeScreen.dart';

class Login extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _countryCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false; // Moved _rememberMe to the State class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/png/kaar_logo.png',
                    // Replace with your image asset path
                    width: 200,
                    height: 300,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextView(
                  text: "User Name",
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: CustomTextField(
                  controller: _usernameController,
                  hintText: "User Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                // Add spacing between fields
                // Add more CustomTextField widgets with validators
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextView(
                  text: "Company Code",
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  controller: _countryCodeController,
                  hintText: "Country Code",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextView(
                  text: "Password",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    elevation: 4, // Adjust the elevation value as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                  )),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe =
                              value ?? false; // Update the _rememberMe variable
                        });
                      },
                    ),
                    Text('Remember me'),

                    Spacer(),
                    // This will create space between the checkbox and the text
                    GestureDetector(
                      onTap: () {
                        // Add your Forgot Password logic here
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Validation successful, navigate to the next screen
                          String username = _usernameController.text;
                          String countryCode = _countryCodeController.text;
                          String password = _passwordController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Username: $username\nCountry Code: $countryCode\nPassword: $password'),
                            ),
                          );
                        }

                        // Perform sign-up logic
                      },
                    )),
              ),
              Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:  RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: 'By continuing, you agree to accept our '),

                            TextSpan(text: ' Privacy Policy', style: TextStyle(color: AppColors.primaryColor)),
                            TextSpan(text: '\n&'),
                            TextSpan(text: ' Terms of Service.', style: TextStyle(color: AppColors.primaryColor)),
                          ],
                        ),
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
