import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';

class ScaffoldHelperWidget extends StatelessWidget {
  const ScaffoldHelperWidget({
    super.key,
    required this.child,
    required this.backgroundImage,
  });

  final Widget child;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}

class BText extends StatelessWidget {
  const BText(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: textTheme.displayMedium!.copyWith(shadows: [
        const Shadow(
          color: AppColors.white,
          offset: Offset(1, 1),
          blurRadius: 10,
        ),
      ]),
    );
  }
}

class BButton extends StatefulWidget {
  const BButton({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;

  @override
  State<BButton> createState() => _BButtonState();
}

class _BButtonState extends State<BButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          widget.title,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class WhiteBorderBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final Color? color;
  const WhiteBorderBox({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class BankingBackButton extends StatelessWidget {
  const BankingBackButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            "assets/icons/back_arrow.png",
            scale: 1.2,
            color: AppColors.white,
          ),
          SizedBox(width: 2.w),
          Text(
            "Back",
            style: theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
