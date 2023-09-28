import 'dart:io';

import 'package:e_delivery/constants.dart';
import 'package:e_delivery/service/api_services.dart';
import 'package:e_delivery/widgets/major_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hand_signature/signature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/argument.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ConfirmDeliveryProcess extends StatefulWidget {
  const ConfirmDeliveryProcess({super.key, this.args});
  final ConfirmDeliveryArguments? args;

  @override
  State<ConfirmDeliveryProcess> createState() => _ConfirmDeliveryProcessState();
}

class _ConfirmDeliveryProcessState extends State<ConfirmDeliveryProcess> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  bool isconfirmedLoading = false;
  bool isSendOtpLoading = false;
  APIServices? api;
  bool? _picked = false;
  bool? _picked2 = false;
  // bool? _is_verified = false;
  bool? _is_verified2 = false;
  bool? isOtpConfirm = false;
  HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.45,
    velocityRange: 1.5,
  );
  ValueNotifier<String?> img = ValueNotifier<String?>(null);

  File? selectedImg;
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future pickImagefromGallery() async {
    // final img = await ImagePicker().pickImage(source: ImageSource.camera);
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img == null) return;
    setState(() {
      selectedImg = File(img.path);
    });
  }

  @override
  void initState() {
    super.initState();
    api = APIServices();
  }

  sendOtp() async {
    setState(() {
      isSendOtpLoading = true;
    });
    // send otp to the customer
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var staffId = prefs.getString('staff_id');
    var clientId = prefs.getString('client_id');
    // var noteId = prefs.getString('note_id');
    var phone = '232' + phoneController.text;

    var response = await api!.sendOTPcode(
      // phoneController.text,
      phone,
      nameController.text,
      staffId!,
      widget.args!.noteId!,
      clientId!,
    );

    debugPrint(response);
    if (response == 'OTP Sent') {
      setState(() {
        isSendOtpLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP Sent'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP Not Sent'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return response;
  }

  sendOtp2() async {
    setState(() {
      isSendOtpLoading = true;
    });
    // send otp to the customer
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var staffId = prefs.getString('staff_id');
    var clientId = prefs.getString('client_id');
    // var noteId = prefs.getString('note_id');

    var response = await api!.sendOTPcode(
      widget.args!.customerPhone!,
      widget.args!.customerName!,
      staffId!,
      widget.args!.noteId!,
      clientId!,
    );

    if (response == 'OTP Sent') {
      setState(() {
        isSendOtpLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('OTP Sent')),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('OTP Not Sent')),
          backgroundColor: Colors.red,
        ),
      );
    }
    return response;
  }

  confirmOTP() async {
    // confirm otp
    setState(() {
      isLoading = true;
    });
    var response = await api!.confirmOTP(
      widget.args!.noteId!,
      otpController.text,
    );

    print(response);

    if (response == 'Valid') {
      setState(() {
        isOtpConfirm = true;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('OTP Confirmed')),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        isOtpConfirm = false;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Invalid OTP')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  updateNote() async {
    setState(() {
      isconfirmedLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var staffId = prefs.getString('staff_id');
    var clientId = prefs.getString('client_id');
    var response = await api!.updateNote(
        selectedImg!, img, staffId!, widget.args!.noteId!, clientId!);

    print(widget.args!.noteId!);
    print(staffId);
    print(clientId);
    print(selectedImg.toString());
    print(img);

    if (response == 'Confirmed') {
      setState(() {
        isconfirmedLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Delivery Confirmed')),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        isconfirmedLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Delivery Not Confirmed')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isconfirmedLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Confirm for: ${widget.args!.customerName}'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormBuilderRadioGroup(
                    activeColor: kPrimaryColor,
                    initialValue: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText:
                          'Is ${widget.args!.customerName} receiving the delivery?',
                      labelStyle: mediumText.copyWith(fontSize: 20),
                    ),
                    name: 'receiver', // Changed to 'receiver' for consistency
                    // validator: FormBuilderValidators.required(),
                    options: const [
                      FormBuilderFieldOption(
                        value: false,
                        child: Text('Yes'),
                      ),
                      FormBuilderFieldOption(
                        value: true,
                        child: Text('No'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _picked =
                            value; // No need to parse, as the values are already boolean
                      });
                    },
                  ),
                  3.verticalSpace,
                  _picked!
                      ? Column(
                          children: [
                            const Text(
                              'Please enter the name and number of receiver.',
                            ),
                            2.verticalSpace,
                            Row(
                              children: [
                                SizedBox(
                                  width: 0.465.sw,
                                  child: FormBuilderTextField(
                                    name: 'name',
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: kTextColor,
                                      )),
                                      labelText: 'Enter Name',
                                      labelStyle: TextStyle(
                                        color: kTextColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kTextColor,
                                        ),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      // FormBuilderValidators.minLength(5),
                                    ]),
                                  ),
                                ),
                                6.horizontalSpace,
                                SizedBox(
                                  width: 0.465.sw,
                                  child: FormBuilderTextField(
                                    name: 'phone',
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: kTextColor,
                                      )),
                                      labelText: 'Enter Phone',
                                      labelStyle: TextStyle(
                                        color: kTextColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kTextColor,
                                        ),
                                      ),
                                      prefix: Text(
                                        '+232',
                                        style: TextStyle(
                                          color: kTextColor,
                                        ),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose(
                                      [
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.maxLength(8),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            8.verticalSpace,
                            _is_verified2!
                                ? Column(
                                    children: [
                                      Text(
                                          'Please enter the 6 digit code sent to ${nameController.text}'),
                                      5.verticalSpace,
                                      FormBuilderTextField(
                                        controller: otpController,
                                        name: 'otp',
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          suffixIcon: isOtpConfirm!
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )
                                              : Icon(Icons.close,
                                                  color: Colors.red),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: kTextColor,
                                          )),
                                          labelText: 'Enter OTP',
                                          labelStyle: TextStyle(
                                            color: kTextColor,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: kTextColor,
                                            ),
                                          ),
                                        ),
                                        validator:
                                            FormBuilderValidators.compose(
                                          [
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.maxLength(6),
                                          ],
                                        ),
                                      ),
                                      3.verticalSpace,
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          // height: 30,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  textStyle: const TextStyle(
                                                    color: kPrimaryColor,
                                                  ),
                                                  backgroundColor:
                                                      Colors.grey[600],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  )),
                                              onPressed: () {
                                                confirmOTP();
                                              },
                                              child: isLoading
                                                  ? const CircularProgressIndicator()
                                                  : const Text(
                                                      'confirm OTP!',
                                                      style: TextStyle(
                                                          color: kWhiteColor),
                                                    )),
                                        ),
                                      ),
                                      3.verticalSpace,
                                      Row(
                                        children: [
                                          _buildSvgView(img, () {
                                            signField(context);
                                          }),
                                          6.horizontalSpace,
                                          selectedImg != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    pickImagefromGallery();
                                                  },
                                                  child: Container(
                                                    width: 0.45.sw,
                                                    height: 96.0,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      color: Colors.white30,
                                                    ),
                                                    child: Image.file(
                                                      selectedImg!,
                                                      width: double.infinity,
                                                      height: 96.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    pickImagefromGallery();
                                                  },
                                                  child: Container(
                                                    width: 0.45.sw,
                                                    height: 96.0,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      color: Colors.white30,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Center(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  color:
                                                                      kPrimaryColor),
                                                              Text(
                                                                'Take Photo',
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      5.verticalSpace,
                                      CustomMajorButton(
                                        text: "Confirm Delivery",
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .saveAndValidate()) {
                                            if (isOtpConfirm == true) {
                                              updateNote();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Center(
                                                      child: Text(
                                                          'Please Confirm OTP')),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          } else {
                                            print("validation failed");
                                          }
                                        },
                                        color: kTextColor, //
                                      ),
                                    ],
                                  )
                                : CustomMajorButton(
                                    text: "Get Code",
                                    onPressed: () {
                                      if (_formKey.currentState!
                                          .saveAndValidate()) {
                                        setState(() {
                                          _is_verified2 = true;
                                        });
                                        sendOtp();
                                        // print(_formKey.currentState!.value);
                                      } else {
                                        print("validation failed");
                                      }
                                    },
                                    color: kTextColor,
                                  ),
                            // 8.verticalSpace,
                          ],
                        )
                      : _picked2!
                          ? Column(
                              children: [
                                Text(
                                    'Please enter the 6 digit code sent to ${widget.args!.customerName}'),
                                5.verticalSpace,
                                FormBuilderTextField(
                                  name: 'otp',
                                  controller: otpController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    // check if isOtpConfirm is true then return a surfix checked icon
                                    suffixIcon: isOtpConfirm!
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(Icons.close, color: Colors.red),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: kTextColor,
                                    )),
                                    labelText: 'Enter OTP',
                                    labelStyle: TextStyle(
                                      color: kTextColor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kTextColor,
                                      ),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose(
                                    [
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.maxLength(6),
                                    ],
                                  ),
                                ),
                                3.verticalSpace,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Resend OTP!',
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            )),
                                      ),
                                      SizedBox(
                                        // height: 30,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                textStyle: const TextStyle(
                                                  color: kPrimaryColor,
                                                ),
                                                backgroundColor:
                                                    Colors.grey[600],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                )),
                                            onPressed: () {
                                              // validate otp
                                              if (_formKey.currentState!
                                                  .saveAndValidate()) {
                                                confirmOTP();
                                              } else {
                                                print("validation failed");
                                              }
                                            },
                                            child: const Text(
                                              'confirm OTP!',
                                              style:
                                                  TextStyle(color: kWhiteColor),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                10.verticalSpace,
                                Row(
                                  children: [
                                    _buildSvgView(img, () {
                                      signField(context);
                                    }),
                                    6.horizontalSpace,
                                    selectedImg != null
                                        ? GestureDetector(
                                            onTap: () {
                                              pickImagefromGallery();
                                            },
                                            child: Container(
                                              width: 0.45.sw,
                                              height: 96.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                color: Colors.white30,
                                              ),
                                              child: Image.file(
                                                selectedImg!,
                                                width: double.infinity,
                                                height: 96.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              pickImagefromGallery();
                                            },
                                            child: Container(
                                              width: 0.45.sw,
                                              height: 96.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                color: Colors.white30,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.camera_alt,
                                                            color:
                                                                kPrimaryColor),
                                                        Text(
                                                          'Take Photo',
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                10.verticalSpace,
                                CustomMajorButton(
                                  text: "Confirm Delivery",
                                  onPressed: () {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      if (isOtpConfirm == true) {
                                        updateNote();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Center(
                                                child:
                                                    Text('Please Confirm OTP')),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      print("validation failed");
                                    }
                                  },
                                  color: kTextColor, //
                                ),
                              ],
                            )
                          : CustomMajorButton(
                              text: "Get Code",
                              onPressed: () {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  setState(() {
                                    _picked2 = true;
                                  });
                                  sendOtp2();
                                  // print(_formKey.currentState!.value);
                                } else {
                                  print("validation failed");
                                }
                              },
                              color: kTextColor,
                            ),

                  // : _is_verified!
                  //     ? Column(
                  //         children: [
                  //           Text(
                  //               'Please enter the 6 digit code sent to ${widget.args!.customerName}'),
                  //           8.verticalSpace,
                  //           FormBuilderTextField(
                  //             name: 'otp',
                  //             keyboardType: TextInputType.number,
                  //             decoration: const InputDecoration(
                  //               border: OutlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                 color: kTextColor,
                  //               )),
                  //               labelText: 'Enter OTP',
                  //               labelStyle: TextStyle(
                  //                 color: kTextColor,
                  //               ),
                  //               focusedBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                   color: kTextColor,
                  //                 ),
                  //               ),
                  //             ),
                  //             validator: FormBuilderValidators.compose(
                  //               [
                  //                 FormBuilderValidators.required(),
                  //                 FormBuilderValidators.maxLength(6),
                  //               ],
                  //             ),
                  //           ),
                  //           5.verticalSpace,
                  //           CustomMajorButton(
                  //             text: "Confirm OTP",
                  //             onPressed: () {
                  //               if (_formKey.currentState!
                  //                   .saveAndValidate()) {
                  //                 print(_formKey.currentState!.value);
                  //               } else {
                  //                 print("validation failed");
                  //               }
                  //               setState(() {
                  //                 _is_verified = false;
                  //               });
                  //             },
                  //             color: kTextColor, //
                  //           ),
                  //           5.verticalSpace,
                  //           CustomMajorButton(
                  //             text: "Sign Here",
                  //             onPressed: () {
                  //               signField(context);
                  //             },
                  //             color: kTextColor, //
                  //           )
                  //         ],
                  //       )
                  //     : CustomMajorButton(
                  //         text: "Send OTP",
                  //         onPressed: () {
                  //           if (_formKey.currentState!.saveAndValidate()) {
                  //             print(_formKey.currentState!.value);
                  //           } else {
                  //             print("validation failed");
                  //           }
                  //           setState(() {
                  //             _is_verified = true;
                  //           });
                  //         },
                  //         color: kTextColor, //
                  //       ),

                  // GestureDetector(
                  //   onTap: () {
                  //     pickImagefromGallery();
                  //   },
                  //   child: _imagePicker(img),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> signField(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: 0.6.sh,
            child: CupertinoAlertDialog(
              title: const Text('Sign Here'),
              content: SizedBox(
                height: 0.6.sh,
                width: 0.75.sw,
                child: HandSignature(
                  control: control,
                  color: Colors.black,
                  type: SignatureDrawType.shape,
                  width: 1,
                  maxWidth: 1.6,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    control.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    img.value = control.toSvg(
                      color: Colors.blueGrey,
                      type: SignatureDrawType.shape,
                      fit: true,
                    );
                    var json = control.toMap();
                    control.importData(json);
                    control.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          );
        });
  }
}

Widget _buildSvgView(img, Function() signHere) => GestureDetector(
      onTap: signHere,
      child: Container(
        width: 0.45.sw,
        height: 96.0,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white30,
        ),
        child: ValueListenableBuilder<String?>(
          valueListenable: img,
          builder: (context, data, child) {
            if (data == null) {
              return GestureDetector(
                onTap: signHere,
                child: Container(
                  color: Colors.white,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.create,
                        color: kPrimaryColor,
                        // size: 30,
                      ),
                      Text('Sign Here'),
                    ],
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.string(
                data,
                placeholderBuilder: (_) => Container(
                  color: Colors.lightBlueAccent,
                  child: const Center(
                    child: Text('parsing data(svg)'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

Widget _imagePicker(img) => Container(
      width: 192.0,
      height: 96.0,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white30,
      ),
      child: ValueListenableBuilder<String?>(
        valueListenable: img,
        builder: (context, data, child) {
          if (data == null) {
            return Container();
          }

          return GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.blueGrey,
                size: 30,
              ),
            ),
          );
        },
      ),
    );

// ···
 