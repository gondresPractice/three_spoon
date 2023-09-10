import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/data/model/create_customer_response.dart';
import 'package:tiga_sendok_app/data/model/customer_response.dart';
import 'package:tiga_sendok_app/page/customer/manage_customer_screen.dart';
import 'package:tiga_sendok_app/page/home_screen.dart';
import 'package:tiga_sendok_app/provider/pre_login_provider.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import '../../provider/customer_provider.dart';
import '../../utils/widgets/get_widgets.dart';

class InputCustomerScreen extends StatefulWidget {
  InputCustomerScreen({super.key, this.customer});

  Data? customer;
  @override
  State<InputCustomerScreen> createState() => _InputCustomerScreenState();
}

class _InputCustomerScreenState extends State<InputCustomerScreen> {
  final GetWidget logoImage = GetWidget();

  late CustomerProvider customerProvider;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int? customerId;
  bool isHide = true;
  bool isLoading = false;

  String? name;
  String? gender;
  int? phone;

  List<String> radioOptions = [
    'male',
    'female',
    'other',
  ];
  int? selectedOption;

  @override
  void initState() {
    if (widget.customer != null) {
      nameController.text = widget.customer!.name.toString();
      phoneController.text = widget.customer!.phone.toString();
      phone = int.parse(widget.customer!.phone.toString());
      customerId = widget.customer!.id;
      if (widget.customer!.gender == "male") {
        selectedOption = 0;
      }
      if (widget.customer!.gender == "female") {
        selectedOption = 1;
      }
      if (widget.customer!.gender == "other") {
        selectedOption = 2;
      }
    }
    super.initState();
  }

  Future<void> inputCustomer() async {
    if (selectedOption != null) {
      gender = radioOptions[selectedOption!].toString();
    }

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        gender == null) {
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: baseString.warningLogin);
    }
    name = nameController.text;
    phone = int.tryParse(phoneController.text.toString());
    if (widget.customer != null) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
          text: baseString.pleaseWait);
      await customerProvider.updateCustomer(
          customerId!, name!, gender!, phone!);
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
          text: baseString.pleaseWait);
      await customerProvider.createNewCustomer(name!, gender!, phone!);
    }

    if (customerProvider.isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ManageCustomerScreen()),
      );
    } else {
      Navigator.pop(context);
      await CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: baseString.errorInputCustomer);
    }
  }

  Future<void> deleteCustomer() async {
    if (customerProvider.isLoading) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
          text: baseString.pleaseWait);
    }

    await customerProvider.deleteCustomer(customerId!!);

    if (customerProvider.isSuccess) {
      customerProvider.getListCustomer();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ManageCustomerScreen()),
      );
    } else {
      await CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: baseString.errorInputCustomer);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    customerProvider = Provider.of<CustomerProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: baseColor.colorPrimary,
          title: Text("New Customer"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GetWidget().getText(context, "Name"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GetWidget().getTextField(context,
                                nameController, 'Fill customer name', 10, 10),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetWidget().getText(context, "Gender"),
                        Expanded(
                          child: Column(
                            children: radioOptions
                                .asMap()
                                .entries
                                .map(
                                  (MapEntry<int, String> entry) =>
                                      RadioListTile<int?>(
                                    title: Text(entry.value),
                                    value: entry.key,
                                    groupValue: selectedOption,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedOption = value;
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 0, bottom: 10.0, top: 20),
                          child: GetWidget().getText(context, 'Phone'),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GetWidget().getTextFieldNumberType(context,
                                phoneController, 'Fill customer phone', 10, 10),
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child: ButtonPrimary(
                      btnClick: inputCustomer,
                      text: widget.customer != null ? "Update" : "Input",
                    )),
                    Visibility(
                      visible: widget.customer != null,
                      child: Center(
                          child: ButtonOutline(
                        btnClick: deleteCustomer,
                        text: 'Delete',
                      )),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
