import 'package:flutter/material.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;

class GetWidget {
  Widget getLogoImage(double height, double width) {
    var assetImage = const AssetImage(baseImage.appLogo);
    var logoImage = Image(
      image: assetImage,
      width: width,
      height: height,
    );

    return logoImage;
  }

  Widget getTextField(
    BuildContext context,
    TextEditingController controller,
    String textHint,
    double leftPadding,
    double rightPadding,
  ) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding, right: rightPadding, bottom: 15.0),
      child: TextField(
        readOnly: false,
        textAlign: TextAlign.start,
        controller: controller,
        style: const TextStyle(
            color: baseColor.colorSecondary,
            fontSize: baseDimens.fontSize16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
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

  Widget getTextFieldDetail(
    BuildContext context,
    String textHint,
    double leftPadding,
    double rightPadding,
  ) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding, right: rightPadding, bottom: 15.0),
      child: TextField(
        readOnly: false,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: baseColor.colorSecondary,
            fontSize: baseDimens.fontSize16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
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

  Widget getTextField2(
      BuildContext context,
      TextEditingController controller,
      String textHint,
      double leftPadding,
      double rightPadding,
      Function(String) function) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding, right: rightPadding, bottom: 15.0),
      child: TextField(
        onChanged: (text) {
          function(text);
        },
        readOnly: false,
        textAlign: TextAlign.start,
        controller: controller,
        style: const TextStyle(
            color: baseColor.colorSecondary,
            fontSize: baseDimens.fontSize16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
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

  Widget getText(BuildContext context, String text) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: TextAlign.start,
      style: const TextStyle(
          fontSize: baseDimens.fontSize16, color: baseColor.colorPrimary),
    );
  }

  Widget getTextTitle(BuildContext context, String text) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: TextAlign.start,
      style: const TextStyle(
          fontSize: baseDimens.fontSize32,
          color: baseColor.colorPrimary,
          fontWeight: FontWeight.bold),
    );
  }

  Widget getTextRight(BuildContext context, String text) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: TextAlign.start,
      style:
          const TextStyle(fontSize: baseDimens.fontSize16, color: Colors.black),
    );
  }

  Widget getTextCenter(BuildContext context, String text) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: baseDimens.fontSize16,
              color: baseColor.colorPrimary),
        ),
      ),
    );
  }

  Widget getButtonBottom(BuildContext context, String text) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: SizedBox(
          width: screenWidth / 2,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(baseColor.colorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.white, width: 0),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              text,
              style: const TextStyle(fontSize: baseDimens.fontSize16),
            ),
          ),
        ),
      ),
    );
  }

  // Widget getRoundedImage(BuildContext context) {
  //   var assetImage = const AssetImage(baseImage.profileImage);
  //   var logoImage = Image(
  //     image: assetImage,
  //     height: 300,
  //   );

  //   return Container(
  //     width: 50,
  //     height: 50,
  //     decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         border: Border.all(color: Colors.grey),
  //         image: DecorationImage(image: assetImage, fit: BoxFit.fill)),
  //   );
  // }

  Widget homeFeatures(
      BuildContext context, String text, AssetImage assetImage) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: screenHeigth / 20, left: screenWidth / 8),
      child: Container(
        width: 175,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: baseColor.colorPrimary, width: 2)),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Center(
            child: Column(children: [
              Image(
                image: assetImage,
                width: 60,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: baseColor.colorPrimary),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget getTextArea(String text, TextEditingController controller,
      double leftPadding, double rightPadding) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            fillColor: baseColor.colorPrimary,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: baseColor.colorPrimary, width: 2.0))),
        maxLines: 4,
      ),
    );
  }

  Widget getBackgroundTitle(String text) {
    return Container(
      height: 50,
      width: double.infinity,
      color: baseColor.colorBackground,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
            color: baseColor.colorPrimary,
            fontWeight: FontWeight.bold,
            fontSize: baseDimens.fontSize18),
      )),
    );
  }

  Widget getTextFieldReadOnly(
    BuildContext context,
    TextEditingController controller,
    String textHint,
    double leftPadding,
    double rightPadding,
  ) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding, right: rightPadding, bottom: 15.0),
      child: TextField(
        onChanged: (text) {},
        readOnly: true,
        textAlign: TextAlign.start,
        controller: controller,
        style: const TextStyle(
            color: baseColor.colorSecondary,
            fontSize: baseDimens.fontSize16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
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

  Widget getTextFieldNumberType(
    BuildContext context,
    TextEditingController controller,
    String textHint,
    double leftPadding,
    double rightPadding,
  ) {
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding, right: rightPadding, bottom: 15.0),
      child: TextField(
        onChanged: (text) {},
        readOnly: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.start,
        controller: controller,
        style: const TextStyle(
            color: baseColor.colorSecondary,
            fontSize: baseDimens.fontSize16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
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

  Widget getTextAreaReadOnly(String text, TextEditingController controller,
      double leftPadding, double rightPadding) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: TextField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            fillColor: baseColor.colorPrimary,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: baseColor.colorPrimary, width: 2.0))),
        maxLines: 4,
      ),
    );
  }

  Widget getSymbolMandatory() {
    return const Text(
      '*',
      style: TextStyle(
          fontSize: 17, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Widget getStateText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 17,
          color: baseColor.colorPrimary,
          fontWeight: FontWeight.w400),
    );
  }
}
