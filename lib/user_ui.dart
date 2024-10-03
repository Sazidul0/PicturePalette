import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserUi extends StatelessWidget {
  const UserUi({super.key});



  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      // body: SafeArea(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: size.height * 0.05),
                Container(
                  width: size.width,
                  height: size.width * 2,
                  decoration: BoxDecoration(color: Color(0xffF7DDDD)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Picture Palette',
                              style: TextStyle(fontSize: size.width * 0.09, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Capture Your Moments!',
                              style: TextStyle(fontSize: size.width * 0.06),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),
                        Text(
                          'With PicturePalette, you can easily store and access all your favorite images in one place.',
                          style: TextStyle(fontSize: size.width * 0.049),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.02),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width * 0.2, size.width*0.14),
                            backgroundColor: Color(0xff2463EB), // Set the background color to blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(size.width * 0.03), // Set the border radius
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Start Saving Images Now!',
                            style: TextStyle(fontSize: size.width * 0.04, color: Colors.white, fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Image.asset("assets/images/clocks.jpg",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: size.width * 0.06,
                        runSpacing: size.height * 0.05,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.cloud_upload, size: size.width * 0.08),
                              Text(
                                'Store Effortlessly',
                                style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Save as many images as you like without limits, all in one secure place.',
                                style: TextStyle(fontSize: size.width * 0.035),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.coronavirus_sharp, size: size.width * 0.08),
                              Text(
                                'Navigate Smoothly',
                                style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Easily browse through your saved images with a sleek and intuitive interface.',
                                style: TextStyle(fontSize: size.width * 0.035),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.star_border_purple500_outlined, size: size.width * 0.08),
                              Text(
                                'Access Instantly',
                                style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Get quick access to your favorite images whenever you need them.',
                                style: TextStyle(fontSize: size.width * 0.035),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.08),

                      Container(
                        width: size.width*.9,
                        height: size.height*.0001,
                        decoration: BoxDecoration(color: Colors.black),
                      ),

                      SizedBox(height: size.height * 0.03),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.developer_mode, size: size.width * 0.06),
                              Text(
                                '  Sazidul Islam',
                                style: TextStyle(fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            'Copyright 2024',
                            style: TextStyle(fontSize: size.width * 0.025),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      // ),
    );
  }

}
