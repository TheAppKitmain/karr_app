import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/login/dataclass/LoginDataCLass.dart';
import 'package:kaar/controller/login/dataclass/User.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/MyHomePage.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:kaar/controller/home/HomeScreen.dart';
import 'package:kaar/widgets/WebView.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _isObscure = true;
  bool _isLoading = false;
  // Track loading state


  final dio = Dio();

  Future<Map<String, dynamic>?> login() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/login',
        queryParameters: {

          'password': _passwordController.text,
          'email': _emailController.text,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;
        final logo = responseData['logo'] as String;

        print(logo);


        if (status) {
          final userJson = responseData['user'] as Map<String, dynamic>;
          final user = User.fromJson(userJson);
          print('Login successful: $message');
          return {
            'status': status,
            'message': message,
            'user': user,
            'logo':logo,
          };
        } else {
          // Handle the case where login failed
          print('Login failed: $message');
          return {
            'status': status,
            'message': message,
          };
        }
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
    SharedPreferences.getInstance().then((prefs) {
      final bool rememberMe = prefs.getBool('remember_me') ?? false;
      if (rememberMe) {
        final String email = prefs.getString('email') ?? '';
        final String number = prefs.getString('usernumber') ?? '';
        final String password = prefs.getString('userpassword') ?? '';

        // Set the values in the text fields
        _emailController.text = email;



        // Update the _rememberMe state
        setState(() {
          _rememberMe = true;
        });
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child:

        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: Image.asset(
                    'assets/png/kaar_logo.png',
                    // Replace with your image asset path
                    width: 200,
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextView(
                  text: "Email",
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: CustomTextField(
                  controller: _emailController,
                  keyboardType:TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                // Add spacing between fields
                // Add more CustomTextField widgets with validators
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextView(
                  text: "Password",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  onTogglePasswordStatus: (){
                    _isObscure=!_isObscure;
                    setState(() {
                    });
                  },
                ),
              ),

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
                          String email = _emailController.text;

                          String password = _passwordController.text;
                          // request(countryCode,password);
                          // final user = await login(countryCode, password);

                          final response = await login();
                          if (response != null) {
                            final status = response['status'] as bool;
                            final message = response['message'] as String;
                            final logo = response['logo'] as String;




                            if (status) {
                              final user = response['user'] as User;
                              // final logo = response['logo'] as String;
                              // Login was successful, handle accordingly
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(' $message'),
                                ),

                              );

                             await SharedStorage().saveStringToLocalStorage('email', user.email!);
                             await SharedStorage().saveStringToLocalStorage('usernumber', user.number!);
                             await SharedStorage().saveStringToLocalStorage('name', user.name!);
                             await SharedStorage().saveStringToLocalStorage('license_number', user.license!);
                             await SharedStorage().saveStringToLocalStorage('userid', "${user.id!}");
                             await SharedStorage().saveStringToLocalStorage('adminid', "${user.userid!}");
                             await SharedStorage().saveBoolToLocalStorage('remember_me', _rememberMe);
                             await SharedStorage().saveStringToLocalStorage('logo', logo);

                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(),), (route) => false);

                              setState(() {
                                _isLoading = false; // Stop loading
                              });
                              // You can also use the 'user' object here if needed
                            } else {
                              // Handle unsuccessful login with the 'message' if needed
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(' $message'),
                                ),

                              );
                              setState(() {
                                _isLoading = false; // Stop loading
                              });
                            }
                          } else {
                            // Handle API request failure here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('API request failed'),
                              ),
                            );
                            setState(() {
                              _isLoading = false; // Stop loading
                            });
                          }
                        }

                        // Perform sign-up logic
                      },
                    )),
              ),

              Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child:  RichText(
                          text:  TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: 'By continuing, you agree to accept our '),

                              TextSpan(text: ' Privacy Policy ', style: TextStyle(color: AppColors.primaryColor),recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebViewClass(title: "Privacy policy",url: "http://ec2-54-146-4-118.compute-1.amazonaws.com/privacy"),
                                    ));

                              }),
                              TextSpan(text: '&'),
                              TextSpan(text: ' Terms of Service.', style: TextStyle(color: AppColors.primaryColor),recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewClass(title: "Terms of Service",url: "http://ec2-54-146-4-118.compute-1.amazonaws.com/terms-conditions"),
                                    ));

                              }),
                            ],
                          ),
                        )
                    )
                ),

            ],
          ),
        ),
      ),
    );
  }
}
