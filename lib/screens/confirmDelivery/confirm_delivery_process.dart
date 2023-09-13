import 'dart:io';

import 'package:e_delivery/constants.dart';
import 'package:e_delivery/widgets/major_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hand_signature/signature.dart';
import '../../utilities/argument.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmDeliveryProcess extends StatefulWidget {
  ConfirmDeliveryProcess({super.key, this.args});
  final ConfirmDeliveryArguments? args;

  @override
  State<ConfirmDeliveryProcess> createState() => _ConfirmDeliveryProcessState();
}

class _ConfirmDeliveryProcessState extends State<ConfirmDeliveryProcess> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool? _picked = false;
  bool? _is_verified = false;
  HandSignatureControl control = new HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.45,
    velocityRange: 1.5,
  );
  ValueNotifier<String?> img = ValueNotifier<String?>(null);
  File? selectedImg;

  Future pickImagefromGallery() async {
    // final img = await ImagePicker().pickImage(source: ImageSource.camera);
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImg = File(img!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Delivery ${widget.args!.customerName}'),
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText:
                        'Is ${widget.args!.customerName} receiving the delivery?',
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
                                    FormBuilderValidators.minLength(5),
                                  ]),
                                ),
                              ),
                              6.horizontalSpace,
                              SizedBox(
                                width: 0.465.sw,
                                child: FormBuilderTextField(
                                  name: 'phone',
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
                          CustomMajorButton(
                            text: "Send OTP",
                            onPressed: () {},
                            color: kTextColor,
                          ),
                        ],
                      )
                    : _is_verified!
                        ? Column(
                            children: [
                              Text(
                                  'Please enter the 6 digit code sent to ${widget.args!.customerName}'),
                              8.verticalSpace,
                              FormBuilderTextField(
                                name: 'otp',
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
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
                              5.verticalSpace,
                              CustomMajorButton(
                                text: "Confirm OTP",
                                onPressed: () {
                                  if (_formKey.currentState!
                                      .saveAndValidate()) {
                                    print(_formKey.currentState!.value);
                                  } else {
                                    print("validation failed");
                                  }
                                  setState(() {
                                    _is_verified = false;
                                  });
                                },
                                color: kTextColor, //
                              ),
                              5.verticalSpace,
                              CustomMajorButton(
                                text: "Sign Here",
                                onPressed: () {
                                  signField(context);
                                },
                                color: kTextColor, //
                              )
                            ],
                          )
                        : CustomMajorButton(
                            text: "Send OTP",
                            onPressed: () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                print(_formKey.currentState!.value);
                              } else {
                                print("validation failed");
                              }
                              setState(() {
                                _is_verified = true;
                              });
                            },
                            color: kTextColor, //
                          ),
                Row(
                  children: [
                    _buildSvgView(img),
                    6.horizontalSpace,
                    selectedImg != null
                        ? Image.file(selectedImg!)
                        : Text('Choose Img')
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    pickImagefromGallery();
                  },
                  child: _imagePicker(img),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> signField(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: 0.6.sh,
            child: CupertinoAlertDialog(
              title: Text('Sign Here'),
              content: Container(
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
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    img.value = await control.toSvg(
                      color: Colors.blueGrey,
                      type: SignatureDrawType.shape,
                      fit: true,
                    );
                    var json = control.toMap();
                    control.importData(json);
                    control.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          );
        });
  }
}

Widget _buildSvgView(img) => Container(
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
            return Container(
              color: Colors.red,
              child: Center(
                child: Text('not signed yet (svg)'),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgPicture.string(
              data,
              placeholderBuilder: (_) => Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Text('parsing data(svg)'),
                ),
              ),
            ),
          );
        },
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
            child: Padding(
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
 