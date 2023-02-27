part of './comps/todo_tile_comps.dart';

class TodoTile extends ConsumerWidget {
  const TodoTile({
    required this.ddu,
    this.onDelete,
    this.onComplete,
    super.key,
  });

  final Ddu ddu;
  final VoidCallback? onDelete;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: DduColors.lightPurple,
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                ref.read(dduesProvider.notifier).remove(ddu);

                if (onDelete != null) {
                  onDelete!();
                }
              },
              backgroundColor: DduColors.gold,
              child: Transform.translate(
                offset: const Offset(1.0, 40.0),
                child: Transform.scale(
                  scale: 4,
                  child: LottieBuilder.asset(
                    DduAnims.starege,
                    frameRate: FrameRate.max,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              DduCheckbox(
                isChecked: ddu.isDdued,
                onTap: onComplete,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TodoTileText(ddu: ddu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
