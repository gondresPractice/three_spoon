import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/page/login_screen.dart';
import 'package:tiga_sendok_app/provider/pre_login_provider.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;
import 'package:tiga_sendok_app/base/base_string.dart' as baseString;
import '../utils/widgets/get_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GetWidget logoImage = GetWidget();
  // final getIt = GetIt.I;
  // late LoginBody loginBody;
  late PreLoginProvider preLoginProvider;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isHide = true;
  bool isLoading = false;
  String token = '';
  // final serviceUtil = ServiceUtil();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initService();
  }

  Future<void> initService() async {}

  Future<void> navigateToHome() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: baseString.warningLogin);
    }

    if (password != confirmPassword) {
      return CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: baseString.warningPassowrd);
    }

    if (name.isNotEmpty ||
        email.isNotEmpty ||
        password.isNotEmpty ||
        confirmPassword.isNotEmpty) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
          text: baseString.pleaseWait);
      await preLoginProvider.register(name, email, password);
    }

    if (preLoginProvider.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      Navigator.pop(context);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: preLoginProvider.message);
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
              Center(child: GetWidget().getTextTitle(context, "Register")),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth / 6, bottom: 10.0, top: 20),
                child: GetWidget().getText(context, 'Name'),
              ),
              GetWidget().getTextField(context, nameController,
                  'Fill your name', screenWidth / 6, screenWidth / 5),
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 6, bottom: 10.0),
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
                  context, passwordController, 'Confirm Password'),
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 6, bottom: 10.0),
                child: GetWidget().getText(
                  context,
                  'Confirm Password',
                ),
              ),
              getTextPasswordField(
                  context, confirmPasswordController, 'Fill confirm password'),
              Center(
                  child: ButtonPrimary(
                btnClick: navigateToHome,
                text: 'REGISTER',
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
