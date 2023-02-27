import 'package:ddu/helpers/ddu_anims.dart';
import 'package:ddu/models/ddu.dart';
import 'package:ddu/providers/ddues_provider.dart';
import 'package:ddu/theme/ddu_colors.dart';
import 'package:ddu/views/shared/todo_tile/comps/todo_tile_comps.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulHookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final _animListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final ddues = ref.watch(dduesProvider);

    return Scaffold(
      backgroundColor: DduColors.lightPurple,
      floatingActionButton: FloatingActionButton(
        splashColor: DduColors.gold,
        backgroundColor: DduColors.lightPurple,
        child: const Icon(Icons.add),
        onPressed: () {
          final isAdded = ref.read(dduesProvider.notifier).add(
                Ddu(
                  id: DateTime.now().millisecond,
                  title: '',
                  isDdued: false,
                ),
              );

          if (isAdded) {
            _animListKey.currentState?.insertItem(
              ddues.length,
              duration: const Duration(milliseconds: 1000),
            );
          }
        },
      ),
      body: Stack(
        children: [
          LottieBuilder.asset(
            DduAnims.night,
            frameRate: FrameRate.max,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 20,
                  ),
                  child: Text(
                    'Good night,\nlulz  🥰🤭',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: DduColors.white,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 6,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    color: DduColors.deepPurple,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: ddues.isEmpty
                          ? Column(
                              children: [
                                LottieBuilder.asset(
                                  DduAnims.sleep,
                                  frameRate: FrameRate.max,
                                  filterQuality: FilterQuality.high,
                                ),
                                Text(
                                  'u have nothing ddu',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(color: DduColors.white),
                                )
                              ],
                            )
                          : AnimatedList(
                              key: _animListKey,
                              padding: const EdgeInsets.fromLTRB(32, 48, 32, 0),
                              initialItemCount: ddues.length,
                              itemBuilder: (context, i, animation) {
                                return ScaleTransition(
                                  scale: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.bounceOut,
                                  ),
                                  child: TodoTile(
                                    ddu: ddues[i],
                                    onComplete: () => ref
                                        .read(dduesProvider.notifier)
                                        .toggle(ddues[i]),
                                    onDelete: () {
                                      ref
                                          .read(dduesProvider.notifier)
                                          .remove(ddues[i]);

                                      _animListKey.currentState!.removeItem(
                                        i,
                                        (context, animation) => ScaleTransition(
                                          scale: CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOut,
                                          ),
                                          child: TodoTile(ddu: ddues[i]),
                                        ),
                                        duration:
                                            const Duration(milliseconds: 250),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
