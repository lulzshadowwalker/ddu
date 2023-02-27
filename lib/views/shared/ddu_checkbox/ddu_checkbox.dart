import 'package:ddu/theme/ddu_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../../../helpers/ddu_anims.dart';

class DduCheckbox extends HookWidget {
  const DduCheckbox({
    this.size = 28,
    this.isChecked = false,
    required this.onTap,
    super.key,
  });

  final double size;
  final bool isChecked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final con = useAnimationController(
      upperBound: 0.6,
      duration: const Duration(milliseconds: 1200),
    );

    useEffect(() {
      isChecked ? con.forward() : con.reverse();

      return null;
    }, [isChecked]);

    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => const LinearGradient(
          colors: [
            DduColors.white,
            DduColors.white,
          ],
        ).createShader(bounds),
        child: LottieBuilder.asset(
          controller: con,
          DduAnims.checkbox,
          height: size,
          width: size,
          frameRate: FrameRate.max,
        ),
      ),
    );
  }
}
