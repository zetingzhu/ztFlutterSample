import 'dart:ui';
import 'package:flutter/material.dart';

class SpeedMyTest extends StatefulWidget {
  const SpeedMyTest({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SpeedMyTest();
  }
}

class _SpeedMyTest extends State<SpeedMyTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0134E6), Color(0xFF1475FB)],
              ),
            ),
          ),

          // 3. Foreground content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Spacer matching Figma margin-top ~ 120-160dp
                        SizedBox(height: screenHeight * 0.12),

                        // App Logo container with premium card design
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x26000000),
                                  // black (0.15 opacity)
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'imgs/ic_app_logo.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.monetization_on,
                                      size: 56,
                                      color: Color(0xFF0134E6),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // App Title
                        const Text(
                          "SolesCash–Préstamos de Crédito",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 48),

                        // Glassmorphic Description Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 28,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0x33FFFFFF),
                                  // white (0.20 opacity)
                                  width: 0.5,
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0x59FFFFFF), // white (0.35 opacity)
                                    Color(0x1AFFFFFF), // white (0.10 opacity)
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDescItem(
                                    "1. 100% préstamo en línea. Solicita hasta S/ 5,000 sin necesidad de acudir a una sucursal.",
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDescItem(
                                    "2. Ofrecemos múltiples opciones de pago para que elijas la que mejor se adapte a ti.",
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDescItem(
                                    "3. Tus datos se protegen con cifrado de nivel bancario. Cuidamos tu privacidad en todo momento.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Interactive start button
                        ElevatedButton(
                          onPressed: () {
                            // Back or show toast
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("¡Bienvenido a SolesCash!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC5FC78),
                            // lime green accent from the design system
                            foregroundColor: const Color(0xFF141A36),
                            // dark text for high contrast
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            "Comenzar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 60, // 外部点击区域宽度
                height: 60, // 外部点击区域高度
                child: Center(
                  child: Icon(
                    // 这里也可以是 Image.asset 或 SvgPicture
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 24, // 内部图标/图片大小
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 100,
            child: IconButton(
              iconSize: 24,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ),
        ],
      ),
    );
  }

  Widget _buildDescItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
