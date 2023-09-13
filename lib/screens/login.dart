import 'package:e_delivery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../widgets/form_text_field.dart';
import '../widgets/major_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _emailOrUsername = TextEditingController();
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        elevation: 0,
        title: const Text(
          "Sign in",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: 1.sh,
              child: Image.asset('assets/images/e-delivery_bg.jpeg',
                  fit: BoxFit.cover,
                  // color: Color.fromRGBO(255, 230, 179, 1.0).withOpacity(1),
                  color: Color.fromRGBO(255, 230, 179, 1.0).withOpacity(1),
                  colorBlendMode: BlendMode
                      .modulate // Adjust the image fitting as per your requirement
                  ),
            ),
            30.verticalSpace,
            Container(
              padding: const EdgeInsets.all(25).w,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                gradient: LinearGradient(
                  colors: [Colors.transparent, Color.fromARGB(255, 23, 20, 20)],
                  stops: [0.05, 0.9],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 0.20.sh,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 0.80.sh + MediaQuery.of(context).viewInsets.bottom,
                padding: const EdgeInsets.all(20).w,
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: subHeadingText,
                      ),
                      5.verticalSpace,
                      Text(
                        'Please sign in to continue!',
                        style: mediumText,
                      ),
                      5.verticalSpace,
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.verticalSpace,
                            Text(
                              'Username or email!',
                              textAlign: TextAlign.start,
                              style: mediumText,
                            ),
                            5.verticalSpace,
                            CustomFormField(
                              name: 'email',
                              hintText: "Enter Your Username or Email",
                              controller: _emailOrUsername,
                              onChange: (val) {
                                print(val);
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            8.verticalSpace,
                            Text(
                              'Password',
                              textAlign: TextAlign.start,
                              style: mediumText,
                            ),
                            6.verticalSpace,
                            CustomFormField(
                              name: 'password',
                              isPassword: isPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      isPasswordVisible = !isPasswordVisible;
                                    },
                                  );
                                },
                              ), // Make sure to use a unique name for each field
                              hintText: "Enter Your Password",
                              controller: _password,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      2.verticalSpace,
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            color: kPrimaryColor,
                          ),
                        ),
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      1.verticalSpace,
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      CustomMajorButton(
                          text: 'Sign in',
                          onPressed: () {
                            _formKey.currentState?.saveAndValidate();
                            debugPrint(_formKey.currentState?.value.toString());

                            // On another side, can access all field values without saving form with instantValues
                            var validate = _formKey.currentState?.validate();
                            if (validate!) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                            // debugPrint(
                            // _formKey.currentState?.instantValue.toString());
                          }),
                      // const Spacer(),
                      3.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an accout?'),
                          // 2.horizontalSpace,
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            child: const Text(
                              'Sign up.',
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
