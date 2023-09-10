import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import 'package:tiga_sendok_app/page/customer/input_customer_screen.dart';
import 'package:tiga_sendok_app/provider/customer_provider.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/utils/widgets/card_list_customer.dart';

class ManageCustomerScreen extends StatefulWidget {
  const ManageCustomerScreen({super.key});

  @override
  State<ManageCustomerScreen> createState() => _ManageCustomerScreenState();
}

class _ManageCustomerScreenState extends State<ManageCustomerScreen> {
  AssetImage icCustomer = const AssetImage(baseImage.icCustomer);
  AssetImage icOrder = const AssetImage(baseImage.icOrder);
  @override
  void initState() {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    customerProvider.getListCustomer();
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
              title: Text("Customer"),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputCustomerScreen()),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            backgroundColor: baseColor.colorBackground,
            body: Consumer<CustomerProvider>(
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
                            child: CardListCustomer(
                                listCustomer: value.listCustomer)),
                      ],
                    ),
                  );
                }
              },
            )));
  }
}
