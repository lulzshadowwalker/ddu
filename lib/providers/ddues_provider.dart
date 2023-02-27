// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ddu.dart';

part 'ddues_provider.g.dart';

@riverpod
class Ddues extends _$Ddues {
  @override
  List<Ddu> build() => const [
        Ddu(
          id: 1,
          title: 'make some coffee',
          isDdued: true,
        ),
        Ddu(
          id: 2,
          title: 'make some more coffee',
          isDdued: true,
        ),
        Ddu(
          id: 3,
          title: 'make some more more coffee',
          isDdued: false,
        ),
      ];

  bool add(Ddu ddu) {
    for (final i in state) {
      if (i.title.isEmpty) return false;
    }

    state = [...state, ddu];
    return true;
  }

  void remove(Ddu ddu) => state = [
        for (final i in state)
          if (i.id != ddu.id) i,
      ];

  void edit(Ddu ddu) => state = [
        for (final i in state) i.id == ddu.id ? ddu : i,
      ];

  void toggle(Ddu ddu) {
    if (ddu.title.isEmpty) return;

    state = [
      for (final i in state) i == ddu ? i.copyWith(isDdued: !i.isDdued) : i,
    ];
  }
}
