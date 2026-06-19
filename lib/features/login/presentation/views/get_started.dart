import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/shared/constants/colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorManager.primaryBlue,
              ColorManager.secondaryBlue,
              ColorManager.lightBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double screenHeight = constraints.maxHeight;
              final double screenWidth = constraints.maxWidth;

              // Normalized scale: 0.0 (very small) → 1.0 (large screens)
              // Clamp between 580 (iPhone SE) and 900 (tablet)
              final double screenScale = ((screenHeight - 580) / (900 - 580))
                  .clamp(0.0, 1.0);

              // Derived sizing tokens
              final double logoHeight = screenWidth * 0.065;
              final double verticalPaddingTop = _lerp(10, 24, screenScale);
              final double circleSize = _lerp(
                screenWidth * 0.82,
                screenWidth * 0.90,
                screenScale,
              );
              final double scooterWidth = _lerp(
                screenWidth * 0.70,
                screenWidth * 0.82,
                screenScale,
              );
              final double heroAreaHeight = _lerp(220, 340, screenScale);
              final double displayFontSize = _lerp(40, 56, screenScale);
              final double subFontSize = _lerp(14, 17, screenScale);
              final double buttonHeight = _lerp(50, 58, screenScale);
              final double buttonFontSize = _lerp(15, 17, screenScale);
              final double gapAfterHero = _lerp(12, 28, screenScale);
              final double gapBetweenButtons = _lerp(12, 16, screenScale);
              final double bottomPadding =
                  MediaQuery.of(context).padding.bottom + 12;

              return MediaQuery(
                // Prevent system text scale from breaking layout
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Logo ──────────────────────────────────────────
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.055,
                              vertical: verticalPaddingTop,
                            ),
                            child: Image.asset(
                              "assets/images/login/login_logo.png",
                              height: logoHeight,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // ── Hero: Circle + Scooter ────────────────────────
                          SizedBox(
                            height: heroAreaHeight,
                            width: screenWidth,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                // White circle — offset right
                                Positioned(
                                  right: -circleSize * 0.15,
                                  child: Container(
                                    width: circleSize,
                                    height: circleSize,
                                    decoration: const BoxDecoration(
                                      color: ColorManager.white,
                                      shape: BoxShape.circle,
                                    ), 
                                  ),
                                ),
                                
                                Positioned(
                                  right: screenWidth * 0.02,
                                  top: 10,
                                  child: Image.asset(
                                    "assets/images/login/scooter.png",
                                    width: scooterWidth,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),
                          // ── Headline + Subtitle ───────────────────────────
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.055,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Let's\nget started",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontSize: displayFontSize,
                                        height: 1.1,
                                        letterSpacing: -0.5,
                                      ),
                                ),
                                SizedBox(height: _lerp(6, 12, screenScale)),
                                Text(
                                  "Everything starts from here",
                                  style: TextStyle(
                                    fontSize: subFontSize,
                                    color: Colors.white70,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: gapAfterHero),
                          // ── Buttons ───────────────────────────────────────
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.06,
                              right: screenWidth * 0.06,
                              bottom: bottomPadding,
                            ),
                            child: Column(
                              children: [
                                _buildButton(
                                  text: "Sign In",
                                  height: buttonHeight,
                                  fontSize: buttonFontSize,
                                  onTap: () =>
                                      context.push('/signin', extra: "login"),
                                ),
                                SizedBox(height: gapBetweenButtons),
                                _buildButton(
                                  text: "Sign Up",
                                  height: buttonHeight,
                                  fontSize: buttonFontSize,
                                  onTap: () =>
                                      context.push('/signin', extra: "signup"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Linear interpolation helper
  double _lerp(double min, double max, double t) => min + (max - min) * t;

  Widget _buildButton({
    required String text,
    required VoidCallback onTap,
    required double height,
    required double fontSize,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.white,
          foregroundColor: ColorManager.lightBlue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
