import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:smart_delivery/Controller/widgets/objects/categoriesBox.dart';
import 'package:smart_delivery/Controller/widgets/objects/restaurantBox.dart';
import 'package:smart_delivery/Controller/widgets/utils/AppColor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BannerModel> listBanners = [
    BannerModel(id: "1", imagePath: 'assets/onboard/onbo1.jpeg'),
    BannerModel(id: "2", imagePath: 'assets/onboard/onbo2.jpeg'),
    BannerModel(id: "3", imagePath: 'assets/onboard/onbo3.jpeg'),
    BannerModel(id: "4", imagePath: 'assets/onboard/onbo4.jpeg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeef3fc),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(clipBehavior: Clip.none, children: [
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 30,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Diliver To:",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "131 IIIT Kota ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16,
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                height: 200,
                width: MediaQuery.of(context).size.width,
                top: 100,
                child: Container(height: 120, child: CategoriesBox()),
              ),
            ]),
            // SizedBox(
            //   height: 120,
            //   child: CategoriesBox(),
            // ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot Offers",
                    style: TextStyle(
                        color: AppColors.ktitle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "All",
                        style: TextStyle(color: AppColors.kmain2),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.kmain2,
                          ))
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            //Offer Banner

            BannerCarousel(
              banners: listBanners,
              customizedIndicators: IndicatorModel.animation(
                  width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
              height: 150,
              spaceBetween: 5,
              activeColor: AppColors.kmain,
              disableColor: Colors.white,
              animation: true,
              borderRadius: 10,
              width: double.infinity,
              indicatorBottom: false,
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Popular Restaurants",
                style: TextStyle(
                  color: AppColors.ktitle,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: RestaurantBox()),
          ],
        ),
      ),
    );
  }
}
