import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import 'package:tiga_sendok_app/page/customer/input_customer_screen.dart';
import 'package:tiga_sendok_app/page/order/input_order_screen.dart';
import 'package:tiga_sendok_app/provider/customer_provider.dart';
import 'package:tiga_sendok_app/provider/order_provider.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/utils/widgets/card_list_customer.dart';

import '../../provider/order_provider.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  AssetImage icCustomer = const AssetImage(baseImage.icCustomer);
  AssetImage icOrder = const AssetImage(baseImage.icOrder);
  @override
  void initState() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getListOrder();
    super.initState();
  }

  void navigateToDaftar() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const DaftarPengirimanScreen()),
    // );
  }

  void navigateToRiwayat() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const FilterPickupScreen()),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: baseColor.colorPrimary,
              title: Text("Order"),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    final customerProvider =
                        Provider.of<CustomerProvider>(context, listen: false);
                    final orderProvider =
                        Provider.of<OrderProvider>(context, listen: false);
                    orderProvider.getListProduct();
                    customerProvider.getListCustomer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputOrderScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            backgroundColor: baseColor.colorBackground,
            body: Consumer<OrderProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return Center(
                      child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              baseColor.colorPrimary)));
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Expanded(
                            child: CardListOrder(listOrder: value.listOrder)),
                      ],
                    ),
                  );
                }
              },
            )));
  }
}
