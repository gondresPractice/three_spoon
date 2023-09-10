import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/data/model/customer_response.dart'
    as DataCustomer;
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import 'package:tiga_sendok_app/page/customer/input_customer_screen.dart';
import 'package:tiga_sendok_app/page/order/input_order_screen.dart';
import 'package:tiga_sendok_app/utils/media_screen_device.dart';

import '../../data/model/order_response.dart' as DataOrder;
import '../../data/model/product_response.dart' as DataProduct;
import '../../provider/order_provider.dart';

class CardListCustomer extends StatefulWidget {
  CardListCustomer({super.key, required this.listCustomer});

  List<DataCustomer.Data> listCustomer;

  @override
  State<CardListCustomer> createState() => _CardListCustomerState();
}

class _CardListCustomerState extends State<CardListCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor.colorBackground,
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InputCustomerScreen(
                        customer: widget.listCustomer[index],
                      )),
            ),
            child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18.0,
                          top: 5,
                          right: AdjustDeviceScreen().screenWidth(context, 15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.listCustomer[index].name != null
                                    ? widget.listCustomer[index].name.toString()
                                    : '-',
                                style: const TextStyle(
                                    fontSize: baseDimens.fontSize16,
                                    fontWeight: FontWeight.bold,
                                    color: baseColor.colorPrimary),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      widget.listCustomer[index].gender ==
                                              'female'
                                          ? baseColor.colorStatusWappr
                                          : baseColor.colorStatusAppr),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)))),
                              onPressed: null,
                              child: Text(
                                widget.listCustomer[index].gender != ''
                                    ? widget.listCustomer[index].gender
                                        .toString()
                                    : '-',
                                style: const TextStyle(
                                    fontSize: baseDimens.fontSize16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        },
        itemCount: widget.listCustomer.length,
      ),
    );
  }
}

class CardListOrder extends StatefulWidget {
  CardListOrder({super.key, required this.listOrder});

  List<DataOrder.Data> listOrder;
  @override
  State<CardListOrder> createState() => _CardListState();
}

class _CardListState extends State<CardListOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor.colorBackground,
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InputOrderScreen(
                          response: widget.listOrder[index],
                        )),
              );
            },
            child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18.0,
                          top: 5,
                          right: AdjustDeviceScreen().screenWidth(context, 15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.listOrder[index].id != null
                                    ? "ID ${widget.listOrder[index].id.toString()}"
                                    : '-',
                                style: const TextStyle(
                                    fontSize: baseDimens.fontSize16,
                                    fontWeight: FontWeight.bold,
                                    color: baseColor.colorPrimary),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      widget.listOrder[index].isPaid == 1
                                          ? baseColor.colorStatusWappr
                                          : baseColor.colorStatusAppr),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)))),
                              onPressed: null,
                              child: Text(
                                widget.listOrder[index].isPaid == 1
                                    ? "PAID"
                                    : 'UNPAID',
                                style: const TextStyle(
                                    fontSize: baseDimens.fontSize16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 30),
                            child: getTextCard(
                                widget.listOrder[index].customer != ''
                                    ? widget.listOrder[index].customer!.name
                                        .toString()
                                    : '-',
                                FontWeight.bold),
                          ),
                          getTextCard(
                              widget.listOrder[index].price != null
                                  ? "\$${widget.listOrder[index].price.toString()}"
                                  : '-',
                              FontWeight.bold)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, top: 0, right: 18.0, bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            widget.listOrder[index].createdAt != ''
                                ? formatDate(widget.listOrder[index].createdAt
                                    .toString())
                                : '-',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        },
        itemCount: widget.listOrder.length,
      ),
    );
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    // Create a DateFormat object for the desired output format
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');

    // Format the DateTime object to the desired format
    String formattedDateTime = formatter.format(dateTime);

    return formattedDateTime;
  }

  Widget getIconCard(String baseImage) {
    return Image.asset(
      baseImage,
      width: 25,
      height: 25,
    );
  }

  Widget getTextCard(String text, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: baseDimens.fontSize16,
          color: Colors.black),
    );
  }
}
