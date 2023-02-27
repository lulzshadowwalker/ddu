// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

@immutable
class Ddu {
  final int id;
  final String title;
  final bool isDdued;

  const Ddu({
    required this.id,
    required this.title,
    required this.isDdued,
  });

  Ddu copyWith({
    int? id,
    String? title,
    bool? isDdued,
  }) {
    return Ddu(
      id: id ?? this.id,
      title: title ?? this.title,
      isDdued: isDdued ?? this.isDdued,
    );
  }

  @override
  String toString() => 'Ddu(id: $id, title: $title, isDdued: $isDdued)';

  @override
  bool operator ==(covariant Ddu other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.isDdued == isDdued;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ isDdued.hashCode;
}
