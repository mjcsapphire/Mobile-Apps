import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VisaCardWidget extends StatelessWidget {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String bankName;

  const VisaCardWidget({
    super.key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = 90.w; // 90% of screen width
    double cardHeight = 40.h; // 30% of screen height

    return Container(
      padding: EdgeInsets.all(4.w),
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
                   colors: [Color(0xFF9C2CF3), Color(0xFF3A49F9)],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2.w),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Bank Name and PayPass Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        bankName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        height: 2.h,
                        width: 0.5.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "Universal Card",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Image.asset(
                    AppAssetsConstant.chip,
                    height: 3.h,
                    // width: 6.w,
                  ),
                ],
              ),
              Image.asset(
                AppAssetsConstant.paypass,
                height: 5.h,
                width: 5.w,
              )
            ],
          ),

          const Spacer(),

          // Card Number Centered
          Center(
            child: Text(
              cardNumber,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Expiry Date and Cardholder Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VALID THRU",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    expiryDate,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARDHOLDER",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    cardHolderName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 1.h),

          // CVV and Amex Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CVV/PIN",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "Tap to view",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Image.asset(
                AppAssetsConstant.amexcardLogo,
                height: 5.h,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VisaCardBackWidget extends StatelessWidget {
  final String cvv;
  final String terms;
  final String condition;

  const VisaCardBackWidget({
    super.key,
    required this.cvv,
    required this.terms,

    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: 240,
      width: 350,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9C2CF3), Color(0xFF3A49F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("For Customer Service Call : 1800-0000-0000",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  )),
          SizedBox(height: 2.h),
          Container(
            height: 6.h,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: Text(
                  "PIN : $cvv",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(terms,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    )),
          ),
          const Spacer(),
          Text(condition,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  )),
        ],
      ),
    );
  }
}
