import 'package:flutter/material.dart';
import 'package:tiga_sendok_app/base/base_colors.dart' as baseColor;
import 'package:tiga_sendok_app/base/base_images.dart' as baseImage;
import 'package:tiga_sendok_app/base/base_dimens.dart' as baseDimens;

class ButtonPrimary extends StatelessWidget {
  ButtonPrimary({Key? key, required this.btnClick, required this.text})
      : super(key: key);
  Function() btnClick;
  String text;

  @override
  Widget build(BuildContext context) {
    return buttonPrimary(context, text);
  }

  Widget buttonPrimary(BuildContext context, String text) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: screenWidth / 2,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(baseColor.colorPrimary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(color: Colors.white, width: 0),
              ),
            ),
          ),
          onPressed: btnClick,
          child: Text(
            text,
            style: const TextStyle(fontSize: baseDimens.fontSize16),
          ),
        ),
      ),
    );
  }
}

class ButtonOutline extends StatelessWidget {
  ButtonOutline({super.key, required this.btnClick, required this.text});
  Function() btnClick;
  String text;
  @override
  Widget build(BuildContext context) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: screenWidth / 2,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(color: baseColor.colorPrimary, width: 0),
              ),
            ),
          ),
          onPressed: btnClick,
          child: Text(
            text,
            style: TextStyle(
                fontSize: baseDimens.fontSize16, color: baseColor.colorPrimary),
          ),
        ),
      ),
    );
  }
}

class HomeFeaturesWidget extends StatelessWidget {
  HomeFeaturesWidget({
    Key? key,
    required this.btnClick,
    required this.text,
    required this.assetImage,
  }) : super(key: key);

  Function() btnClick;
  String text;
  AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return ContainerFeatures(context, text, assetImage);
  }

  Widget ContainerFeatures(
      BuildContext context, String text, AssetImage assetImage) {
    var screenHeigth = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: screenHeigth / 50, left: 0),
      child: GestureDetector(
        onTap: btnClick,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: baseColor.colorPrimary, width: 2)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Column(children: [
                Image(
                  image: assetImage,
                  width: 75,
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: baseColor.colorPrimary),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
