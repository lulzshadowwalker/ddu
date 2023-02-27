part of './todo_tile_comps.dart';

class _TodoTileText extends HookConsumerWidget {
  const _TodoTileText({
    required this.ddu,
  });

  final Ddu ddu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textCon = useTextEditingController(text: ddu.title);
    final animCon =
        useAnimationController(duration: const Duration(milliseconds: 350));

    final textColor = useAnimation(
      ColorTween(
        begin: DduColors.white,
        end: DduColors.gold,
      ).animate(animCon),
    );

    final lineThroughColor = useAnimation(
      ColorTween(
        begin: DduColors.white,
        end: DduColors.grey,
      ).animate(animCon),
    );

    useEffect(() {
      ddu.isDdued ? animCon.forward() : animCon.reverse();

      return null;
    }, [ddu]);

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: 550),
          scale: ddu.isDdued ? 0.95 : 1,
          curve: Curves.easeOut,
          child: TextField(
            cursorColor: DduColors.gold,
            controller: textCon,
            onChanged: (value) => ref.read(dduesProvider.notifier).edit(
                  ddu.copyWith(title: value),
                ),
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
            decoration: InputDecoration(
              hintText: 'add a ddu to your list',
              hintStyle: TextStyle(
                color: DduColors.grey,
                fontSize: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),

        //
        AnimatedBuilder(
          animation: animCon,
          child: Text(
            '${ddu.title.replaceAll(' ', '.')}--', // :)
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              decorationColor: lineThroughColor,
              color: Colors.transparent,
              decorationThickness: 5,
            ),
          ),
          builder: (context, child) => Transform(
            transform: Matrix4.identity()
              ..scale(
                animCon.value,
                1.0,
                1.0,
              ),
            child: child,
          ),
        )
      ],
    );
  }
}
