import 'package:flutter/material.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import 'package:tiga_sendok_app/page/login_screen.dart';
import 'package:tiga_sendok_app/page/order/manage_order_screen.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import '../utils/widgets/get_widgets.dart';
import 'customer/manage_customer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AssetImage icCustomer = const AssetImage(baseImage.icCustomer);
  AssetImage icOrder = const AssetImage(baseImage.icOrder);
  void navigateToOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManageOrderScreen()),
    );
  }

  void navigateToCustomer() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManageCustomerScreen()),
    );
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor.colorBackground,
      body: Center(
        child: Container(
          child: Column(
            children: [
              GetWidget().getLogoImage(300, 450),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeFeaturesWidget(
                    btnClick: navigateToCustomer,
                    text: 'Manage\nCustomer',
                    assetImage: icCustomer,
                  ),
                  HomeFeaturesWidget(
                    btnClick: navigateToOrder,
                    text: 'Manage\Order',
                    assetImage: icOrder,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                    child: ButtonPrimary(
                  btnClick: logout,
                  text: 'LOGOUT',
                )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
