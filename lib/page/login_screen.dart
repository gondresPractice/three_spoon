import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/page/home_screen.dart';
import 'package:tiga_sendok_app/provider/pre_login_provider.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import '../utils/widgets/get_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GetWidget logoImage = GetWidget();
  // final getIt = GetIt.I;
  // late LoginBody loginBody;
  late PreLoginProvider preLoginProvider;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHide = true;
  bool isLoading = false;
  String token = '';
  // final serviceUtil = ServiceUtil();

  @override
  void initState() {
    super.initState();
  }

  Future<void> navigateToHome() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: baseString.warningLogin);
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
          text: baseString.pleaseWait);

      await preLoginProvider.login(email, password);
    }

    if (preLoginProvider.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      await CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: baseString.errorLogin);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    preLoginProvider = Provider.of<PreLoginProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GetWidget().getLogoImage(300, 450),
              Center(child: GetWidget().getTextTitle(context, "Login")),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth / 6, bottom: 10.0, top: 20),
                child: GetWidget().getText(context, 'Email'),
              ),
              GetWidget().getTextField(context, emailController,
                  'Fill Your Email', screenWidth / 6, screenWidth / 5),
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 6, bottom: 10.0),
                child: GetWidget().getText(
                  context,
                  'Password',
                ),
              ),
              getTextPasswordField(
                  context, passwordController, 'Fill your password'),
              Center(
                  child: ButtonPrimary(
                btnClick: navigateToHome,
                text: 'LOGIN',
              ))
            ]),
          ),
        ),
      ),
    );
  }

  Widget getTextPasswordField(
      BuildContext context, TextEditingController controller, String textHint) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth / 6, right: screenWidth / 5, bottom: 15.0),
      child: TextField(
        readOnly: false,
        textAlign: TextAlign.start,
        controller: controller,
        obscureText: isHide,
        style: const TextStyle(
            color: baseColor.colorSecondary,
            fontSize: baseDimens.fontSize16,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: isHide == true
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                isHide = !isHide;
                debugPrint(isHide.toString());
              });
            },
            color: baseColor.colorPrimary,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: baseColor.colorPrimary, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10),
          hintText: textHint,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
