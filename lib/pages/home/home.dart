import 'package:coar/auth/bloc/auth_bloc.dart';
import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/features/user_detail_cubit.dart';
import 'package:coar/pages/cart/cart_screen.dart';
import 'package:coar/pages/home/admin_home/admin_home_page.dart';
import 'package:coar/pages/home/widgets/best_sell_tile_custom.dart';
import 'package:coar/pages/home/widgets/category_tile_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_indicator/scroll_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/driver_custom.dart';
import 'widgets/special_foryou_tile_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _specialForYouScrollController = ScrollController();
  final _bannerCOntroller = PageController();
  final _giftCOntroller = PageController();
  int _currentIndex = 0;
  final int itemCount = 13; // Set this to the number of items you have

  @override
  void initState() {
    super.initState();
    _specialForYouScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double maxScroll = _specialForYouScrollController.position.maxScrollExtent;
    double currentScroll = _specialForYouScrollController.position.pixels;
    setState(() {
      _currentIndex = (currentScroll / maxScroll * (itemCount - 1)).round();
    });
  }

  @override
  void dispose() {
    _specialForYouScrollController.removeListener(_onScroll);
    _specialForYouScrollController.dispose();
    super.dispose();
  }

  List<String> bannerUrl = ['asset/banner2.png', 'asset/banner1.png'];
  List<String> speacialUrl = [
    // 'asset/gold_auspicious.png',
    'asset/gold_dailywear.png',
    'asset/gold_newarriaval.png',
    'asset/diamond_mangalsutras.png'
  ];
  List<String> topDiamondUrl = [
    'asset/diamond_earing.png',
    'asset/diamond_pendants.png',
    'asset/diamond_ring.png',
    'asset/diamond_mangalsutra.png',
    'asset/diamond_chain.png',
    'asset/diamond_chain.png',
    'asset/diamond_bangles.png',
  ];
  List<String> topGoldUrl = [
    'asset/gold_ring.png',
    'asset/gold_tala.png',
    'asset/gold_newarriaval.png',
    'asset/gold_mala.png',
    'asset/gold_earing.png',
  ];
  List<String> giftingUrl = [
    'asset/gift_love.png',
    'asset/gift_for patner.png',
    'asset/gift_birthday.png',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, userstate) {
        if (userstate.userDetails.isAdmin) {
          return AdminHomePage();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            shadowColor: basecolor,
            elevation: 2.sp,
            surfaceTintColor: whiteColor,
            iconTheme: IconThemeData(color: primaryColor, size: 30.sp),
            backgroundColor: whiteColor,
            title: Row(
              children: [
                Image.asset(
                  'asset/cor..jpg',
                  height: 90.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                )
         
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ));
                  },
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    size: 20.sp,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().logout(context);
                  },
                  icon: Icon(
                    CupertinoIcons.power,
                    size: 20.sp,
                  )),
              SizedBox(
                width: 10.w,
              )
            ],
          ),
          // drawer: const Drawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ContainerCustom(
                  width: double.infinity,
                  height: 130,
                  child: ListView.builder(
                    itemCount: topGoldUrl.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HomeCateogryTileCustom(
                        imageUrl: topGoldUrl[index],
                      );
                    },
                  ),
                ),
                ContainerCustom(
                  bgColor: Colors.grey.shade200,
                  width: double.infinity,
                  height: 450,
                  child: PageView.builder(
                    itemCount: bannerUrl.length,
                    controller: _bannerCOntroller,
                    itemBuilder: (context, index) {
                      return ContainerCustom(
                        child: Image.asset(bannerUrl[index]),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SmoothPageIndicator(
                  controller: _bannerCOntroller,
                  count: bannerUrl.length,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: primaryColor,
                    dotColor: Colors.grey,
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                  ),
                ),
                TextCustomWidget(
                  marginBottom: 10.h,
                  containerAlignment: Alignment.center,
                  marginTop: 15.h,
                  text: 'Coar Special',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400,
                      // fontStyle: FontStyle.italic,
                      color: primaryColor),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  text: 'Our top picks,just for you!',
                  textStyle: GoogleFonts.italiana(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: greycolor),
                ),
                const DriverCustom(),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  height: 250,
                  child: ListView.builder(
                    controller: _specialForYouScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: speacialUrl.length,
                    itemBuilder: (context, index) {
                      return SpecialForyouTileCustom(
                        imageUrl: speacialUrl[index],
                      );
                    },
                  ),
                ),
                ScrollIndicator(
                  scrollController: _specialForYouScrollController,
                  width: 50,
                  height: 5,
                  indicatorWidth: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  indicatorDecoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  marginTop: 15.h,
                  text: 'Diamond Best Sellers',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.normal,
                      color: primaryColor),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  text: 'Look at our diamond collection curated just for you',
                  textStyle: GoogleFonts.italiana(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: greycolor),
                ),
                const DriverCustom(),
                ContainerCustom(
                  bgColor: greycolor.withOpacity(.2),
                  marginTop: 10.h,
                  borderRadius: BorderRadius.circular(8.r),
                  marginLeft: 10.w,
                  marginRight: 10.w,
                  border: Border.all(color: greycolor.withOpacity(.4)),
                  height: 180.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      'asset/ss2.jpeg',
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  height: 270,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topDiamondUrl.length,
                    itemBuilder: (context, index) {
                      return BestSellTileCustom(
                        imageUrl: topDiamondUrl[index],
                      );
                    },
                  ),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  // marginTop: 25.h,
                  text: 'Gold Best Sellers',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.normal,
                      color: primaryColor),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  text: 'Look at our gold collection curated just for you',
                  textStyle: GoogleFonts.italiana(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: greycolor),
                ),
                const DriverCustom(),
                ContainerCustom(
                  bgColor: greycolor.withOpacity(.2),
                  // marginTop: 20.h,
                  borderRadius: BorderRadius.circular(8.r),
                  marginLeft: 10.w,
                  marginRight: 10.w,
                  border: Border.all(color: greycolor.withOpacity(.4)),
                  height: 180.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      'asset/ss1.jpeg',
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topGoldUrl.length,
                    itemBuilder: (context, index) {
                      return BestSellTileCustom(
                        imageUrl: topGoldUrl[index],
                      );
                    },
                  ),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  // marginTop: 25.h,
                  text: 'Gifting',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.normal,
                      color: primaryColor),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  text: 'Find the perfect gift',
                  textStyle: GoogleFonts.italiana(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: greycolor),
                ),
                const DriverCustom(),
                ContainerCustom(
                  bgColor: Colors.grey.shade200,
                  width: double.infinity,
                  height: 250,
                  child: PageView.builder(
                    itemCount: giftingUrl.length,
                    controller: _giftCOntroller,
                    itemBuilder: (context, index) {
                      return ContainerCustom(
                          child: ClipRect(
                        child: Image.asset(giftingUrl[index]),
                      ));
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SmoothPageIndicator(
                  controller: _giftCOntroller,
                  count: 5,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: primaryColor,
                    dotColor: Colors.grey,
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                  ),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  marginTop: 25.h,
                  text: 'Shop by Gender',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.normal,
                      color: primaryColor),
                ),
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  text:
                      'First class jewelry for first-class Men,Women & children',
                  textStyle: GoogleFonts.italiana(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: greycolor),
                ),
                const DriverCustom(),
                ContainerCustom(
                  bgColor: greycolor.withOpacity(.2),
                  marginTop: 20.h,
                  borderRadius: BorderRadius.circular(8.r),
                  marginLeft: 10.w,
                  marginRight: 10.w,
                  border: Border.all(color: greycolor.withOpacity(.4)),
                  height: 180.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      'asset/women.png',
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ContainerCustom(
                      bgColor: greycolor.withOpacity(.2),
                      marginTop: 5.h,
                      borderRadius: BorderRadius.circular(8.r),
                      marginLeft: 10.w,
                      marginRight: 10.w,
                      border: Border.all(color: greycolor.withOpacity(.4)),
                      height: 180.h,
                      width: 180.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          'asset/men.png',
                          height: 180.h,
                          width: 180.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ContainerCustom(
                      bgColor: greycolor.withOpacity(.2),
                      marginTop: 5.h,
                      borderRadius: BorderRadius.circular(8.r),
                      marginLeft: 5.w,
                      border: Border.all(color: greycolor.withOpacity(.4)),
                      height: 180.h,
                      width: 180.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          'asset/child.png',
                          height: 180.h,
                          width: 180.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 70.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
