import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/login/dataclass/LoginDataCLass.dart';
import 'package:kaar/controller/login/dataclass/User.dart';
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

  bool _rememberMe = false;
  bool _isLoading = false; // Track loading state


  final dio = Dio();
  void request(String number,String password) async {
    try{
      Response response;
      response = await dio.post('https://codecoyapps.com/karr/api/login?number=$number&password=$password');
      print("this is response ${response.data.toString()}");

      print(response.data.toString());
    }catch(e){
      print(e);
    }

  }



  Future<User?> login(String number, String password) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://codecoyapps.com/karr/api/login',
        queryParameters: {
          'number': number,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final userJson = responseData['user'] as Map<String, dynamic>;

        // Parse the response data into a User object
        final user = User.fromJson(userJson);

        return user;
      } else {
        // Handle error status codes (e.g., show an error message)
        print('API request failed with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('API request error: $e');
      return null;
    }
  }

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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextView(
                  text: "User Name",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextView(
                  text: "Company Code",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
                    const Text('Remember me'),

                    const Spacer(),
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
                    child: _isLoading // Show progress indicator if loading
                    ? CircularProgressIndicator()
                  : PrimaryButton(
                      text: 'Login',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true; // Start loading
                          });
                          // Validation successful, navigate to the next screen
                          String username = _usernameController.text;
                          String countryCode = _countryCodeController.text;
                          String password = _passwordController.text;
                          // request(countryCode,password);
                          final user = await login(countryCode, password);
                          setState(() {
                            _isLoading = false; // Stop loading
                          });
                          if (user != null) {
                            // Login successful, you can use the user data here
                            print('Logged in as ${user.name}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Login Successful'),
                              ),
                            );
                          } else {
                            // Handle login failure
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Incorrect User name or Password'),
                                ));
                            print('Login failed');
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          // );



                        }

                        // Perform sign-up logic
                      },
                    )),
              ),

              Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:  RichText(
                        text: const TextSpan(
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
