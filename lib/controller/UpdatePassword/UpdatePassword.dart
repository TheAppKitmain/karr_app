import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/CustomSnackBar.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isObscure = true;
  String? userid;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
    });
  }

  Future<Map<String, dynamic>?> UpdatePassword() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/password',
        queryParameters: {
          'driver_id': userid,
          'old_password': _oldPasswordController.text,
          'new_password': _newPasswordController.text,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          return {
            'status': status,
            'message': message,
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                  text: "Old Password",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  controller: _oldPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  onTogglePasswordStatus: () {
                    _isObscure = !_isObscure;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextView(
                  text: "New Password",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  onTogglePasswordStatus: () {
                    _isObscure = !_isObscure;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextView(
                  text: "Confirm Password",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  onTogglePasswordStatus: () {
                    _isObscure = !_isObscure;
                    setState(() {});
                  },
                ),
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _isLoading // Show progress indicator if loading
                        ? CircularProgressIndicator()
                        : PrimaryButton(
                            text: 'Update Password',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_newPasswordController.text ==
                                    _confirmPasswordController.text) {
                                  setState(() {
                                    _isLoading = true; // Start loading
                                  });
                                  // Validation successful, navigate to the next screen
                                  String oldPassword =
                                      _oldPasswordController.text;
                                  String newPassword =
                                      _newPasswordController.text;

                                  // request(countryCode,password);

                                  final response = await UpdatePassword();
                                  if (response != null) {
                                    final status = response['status'] as bool;
                                    final message =
                                        response['message'] as String;

                                    if (status) {
                                      // Login was successful, handle accordingly
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(' $message'),
                                        ),
                                      );
                                      CustomDialogBox.show(context, true,
                                          "Update Successfuly", message);

                                      setState(() {
                                        _isLoading = false; // Stop loading
                                      });
                                      // You can also use the 'user' object here if needed
                                    } else {
                                      // Handle unsuccessful login with the 'message' if needed
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                }else{
                                  CustomSnackBar.showSnackBar(context, "Password Does not match");
                                }
                              }

                              // Perform sign-up logic
                            },
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
