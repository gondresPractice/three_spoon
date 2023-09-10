import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/data/model/create_customer_response.dart';
import 'package:tiga_sendok_app/data/model/customer_response.dart';
import 'package:tiga_sendok_app/page/customer/manage_customer_screen.dart';
import 'package:tiga_sendok_app/page/home_screen.dart';
import 'package:tiga_sendok_app/page/order/manage_order_screen.dart';
import 'package:tiga_sendok_app/provider/pre_login_provider.dart';
import 'package:tiga_sendok_app/utils/media_screen_device.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import '../../data/model/order_response.dart' as Order;
import '../../provider/customer_provider.dart';
import '../../provider/order_provider.dart';
import '../../utils/widgets/get_widgets.dart';

class InputOrderScreen extends StatefulWidget {
  InputOrderScreen({super.key, this.response});
  Order.Data? response;
  @override
  State<InputOrderScreen> createState() => _InputOrderScreenState();
}

class _InputOrderScreenState extends State<InputOrderScreen> {
  final GetWidget logoImage = GetWidget();

  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  List<String> customerList = [];
  List<String> customerListTemp = [];
  List<String> productList = [];
  List<String> productListTemp = [];

  String? _selectedCustomer;
  String? _selectedProduct;

  int? orderId;
  int? customerId;
  int? productId;
  int? quantity;
  int? price;

  bool isHide = true;
  bool isLoading = false;
  bool isDetail = false;
  bool isPaid = false;

  int? selectedOption;

  @override
  void initState() {
    setData();

    super.initState();
  }

  void setData() {
    if (widget.response != null) {
      _selectedCustomer = widget.response!.customer!.name;
      _selectedProduct = widget.response!.product!.name;
      orderId = widget.response!.id;
      customerId = widget.response!.customer!.id;
      productId = widget.response!.product!.id;
      quantityController.text = widget.response!.qty.toString();
      priceController.text = widget.response!.price.toString();
      totalController.text = widget.response!.total.toString();
      isDetail = true;

      if (widget.response!.isPaid == 1) {
        isPaid = true;
      }
    }
  }

  Future<void> createNewOrder() async {
    if (quantityController.text.isEmpty ||
        priceController.text.isEmpty ||
        _selectedCustomer == null ||
        _selectedProduct == null) {
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: baseString.warningLogin);
    }
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    if (widget.response != null) {
      await orderProvider.updateOrder(
          orderId!, customerId!, productId!, quantity!, price!);
    } else {
      quantity = int.parse(quantityController.text);
      price = int.parse(priceController.text);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
          text: baseString.pleaseWait);
      await orderProvider.createNewOrder(
          customerId!, productId!, quantity!, price!);
    }

    if (orderProvider.isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ManageOrderScreen()),
      );
    } else {
      Navigator.pop(context);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: baseString.errorInputOrder);
    }
  }

  Future<void> changeStatusPay() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    await orderProvider.changeStatusPay(orderId!);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: baseColor.colorPrimary,
            title: Text("New Order"),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: false,
          body: Consumer<OrderProvider>(
            builder: (context, valueOrder, child) {
              return Container(
                  color: Colors.white,
                  child: Consumer<CustomerProvider>(
                    builder: (context, valueCustomer, child) {
                      var seenCustomer = Set<String>();
                      var seenProduct = Set<String>();
                      customerListTemp.clear();
                      productListTemp.clear();
                      if (customerList.isEmpty) {
                        valueCustomer.listCustomer.forEach(((element) =>
                            customerList.add(element.name.toString())));
                        customerListTemp = customerList
                            .where((customer) => seenCustomer.add(customer))
                            .toList();
                      }

                      if (productList.isEmpty) {
                        valueOrder.listProduct.forEach(((element) =>
                            productList.add(element.name.toString())));
                        productListTemp = productList
                            .where((product) => seenProduct.add(product))
                            .toList();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GetWidget().getText(context, "Customer"),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(
                                          left: AdjustDeviceScreen()
                                              .screenWidth(context, 20),
                                          right: AdjustDeviceScreen()
                                              .screenWidth(context, 35),
                                          top: 10),
                                      child: DropdownButtonFormField<String>(
                                        hint: Text(widget.response != null
                                            ? _selectedCustomer!
                                            : "--SELECT--"),
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0.0,
                                                bottom: 0.0,
                                                left: 10),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: baseColor.colorPrimary,
                                            ))),
                                        value: _selectedCustomer,
                                        focusColor: baseColor.colorPrimary,
                                        elevation: 0,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        onChanged: customerListTemp.isNotEmpty
                                            ? (String? value) {
                                                setState(() {
                                                  valueCustomer.listCustomer
                                                      .forEach((element) {
                                                    if (element.name ==
                                                        value!) {
                                                      customerId = element.id;
                                                    }
                                                  });
                                                  _selectedCustomer = value!;

                                                  debugPrint(
                                                      'seelected$_selectedCustomer');
                                                });
                                              }
                                            : null,
                                        items: customerListTemp.isNotEmpty
                                            ? customerListTemp
                                                .map<DropdownMenuItem<String>>(
                                                    (customer) {
                                                return DropdownMenuItem<String>(
                                                  value: customer,
                                                  child: Text(customer),
                                                );
                                              }).toList()
                                            : null,
                                      ),
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GetWidget().getText(context, "Product"),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(
                                          left: AdjustDeviceScreen()
                                              .screenWidth(context, 13),
                                          right: AdjustDeviceScreen()
                                              .screenWidth(context, 35),
                                          top: 10),
                                      child: DropdownButtonFormField<String>(
                                        hint: Text(widget.response != null
                                            ? _selectedProduct!
                                            : '--Select--'),
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0.0,
                                                bottom: 0.0,
                                                left: 10),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: baseColor.colorPrimary,
                                            ))),
                                        value: _selectedProduct,
                                        focusColor: baseColor.colorPrimary,
                                        elevation: 0,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        onChanged: productListTemp.isNotEmpty
                                            ? (String? value) {
                                                valueOrder.listProduct
                                                    .forEach((element) {
                                                  if (element.name == value!) {
                                                    productId = element.id;
                                                    priceController.text =
                                                        element.price
                                                            .toString();
                                                  }
                                                });
                                                setState(() {
                                                  _selectedProduct = value!;
                                                  debugPrint(
                                                      'seelected$_selectedProduct');
                                                });
                                              }
                                            : null,
                                        items: productListTemp.isNotEmpty
                                            ? productListTemp
                                                .map<DropdownMenuItem<String>>(
                                                    (product) {
                                                return DropdownMenuItem<String>(
                                                  value: product,
                                                  child: Text(product),
                                                );
                                              }).toList()
                                            : null,
                                      ),
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GetWidget().getText(context, "Price"),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: AdjustDeviceScreen()
                                                .screenWidth(context, 10),
                                            right: AdjustDeviceScreen()
                                                .screenWidth(context, 150),
                                            top: 10),
                                        child: GetWidget().getTextFieldReadOnly(
                                            context,
                                            priceController,
                                            'Product Price',
                                            10,
                                            10),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0, bottom: 10.0, top: 20),
                                      child:
                                          GetWidget().getText(context, 'Qty'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: AdjustDeviceScreen()
                                                .screenWidth(context, 6.5),
                                            right: AdjustDeviceScreen()
                                                .screenWidth(context, 40),
                                            top: 0),
                                        child: TextField(
                                          onChanged: (text) {
                                            if (text.isNotEmpty) {
                                              totalController
                                                  .text = (int.parse(text) *
                                                      int.parse(
                                                          priceController.text))
                                                  .toString();
                                            }
                                          },
                                          readOnly: false,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.start,
                                          controller: quantityController,
                                          style: const TextStyle(
                                              color: baseColor.colorSecondary,
                                              fontSize: baseDimens.fontSize16,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: baseColor.colorPrimary,
                                                  width: 2.0),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 0.0,
                                                    bottom: 0.0,
                                                    left: 10),
                                            hintText: "Quantity",
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                            border: const OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0, bottom: 10.0, top: 20),
                                      child:
                                          GetWidget().getText(context, 'Total'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: AdjustDeviceScreen()
                                                .screenWidth(context, 10),
                                            right: AdjustDeviceScreen()
                                                .screenWidth(context, 150),
                                            top: 10),
                                        child: GetWidget().getTextFieldReadOnly(
                                            context,
                                            totalController,
                                            'Total',
                                            10,
                                            10),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: !isPaid,
                                  child: Center(
                                      child: ButtonOutline(
                                    btnClick: createNewOrder,
                                    text: widget.response != null
                                        ? "Update"
                                        : "Submit",
                                  )),
                                ),
                                Visibility(
                                  visible: widget.response != null,
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: SizedBox(
                                      width: screenWidth / 2,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(isPaid
                                                  ? Colors.grey
                                                  : baseColor.colorPrimary),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: const BorderSide(
                                                  color: Colors.white,
                                                  width: 0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (!isPaid) {
                                            changeStatusPay();
                                          }
                                        },
                                        child: Text(
                                          isPaid ? "Already Paid" : "Pay",
                                          style: const TextStyle(
                                              fontSize: baseDimens.fontSize16),
                                        ),
                                      ),
                                    ),
                                  )),
                                ),
                                // Center(
                                //     child: ButtonPrimary(
                                //   btnClick: navigateToHome,
                                //   text: 'Submit',
                                // )),
                              ]),
                        ),
                      );
                    },
                  ));
            },
          )),
    );
  }
}
