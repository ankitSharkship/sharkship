import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/shared/constants/colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/login/login_logo.png",
                        height: 28,
                      ),
                    ),
                  ),

                  /// White circle — sits behind the scooter
                  Center(
                    // Vertically centers the entire widget
                    child: Transform.translate(
                      offset: Offset(
                        size.width * 0.31,
                        0,
                      ), // Move up by 1/2 radius (half cut off)
                      child: Container(
                        width: size.width * 0.92,
                        height: size.width * 0.92,
                        decoration: const BoxDecoration(
                          color: ColorManager.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// Text Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Let's\nget started",
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.white,
                            height: 1.15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Everything start from here",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        _buildButton(
                          text: "Sign In",
                          onTap: () {
                            context.push('/signin', extra: "login");
                          },
                        ),
                        const SizedBox(height: 14),
                        _buildButton(
                          text: "Sign Up",
                          onTap: () {
                            context.push('/signin', extra: "signup");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Scooter image overlaid — overflows the circle naturally
              Positioned(
                top: size.height * 0.04,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    "assets/images/login/scooter.png",
                    width: size.width * 0.88,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 54,
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
