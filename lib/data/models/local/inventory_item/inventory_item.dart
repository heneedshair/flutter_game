import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

abstract class InventoryItem {
  const InventoryItem();

  int get id;
  String get name;
  int get rare;
  int get price;
  String get imageUrl;

  T map<T>({required T Function(Character characher) characher, required T Function(Chest chest) chest});
}

@freezed
class Character extends InventoryItem with _$Character {
  const Character._();

  const factory Character({
    required int id,
    required String name,
    required int rare,
    required int price,
    required String imageUrl,
    required bool isArtificialSpecs,
    required int leftRatings,
    required int spec1,
    required int spec2,
    required int spec3,
    required int spec4,
    required int spec5,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  @override
  T map<T>({required T Function(Character characher) characher, required T Function(Chest chest) chest}) =>
      characher(this);
}

extension ColorExtension on int {
  Color getColorByRarity(ColorScheme colors) {
    return switch (this) {
      0 => colors.primaryContainer,
      1 => Colors.grey,
      2 => Colors.blueAccent,
      3 => Colors.lightGreen,
      4 => colors.error,
      int() => throw Exception('invalid rare value: $this'),
    };
  }
}

@freezed
class Chest extends InventoryItem with _$Chest {
  const Chest._();

  const factory Chest({
    required int id,
    required String name,
    required int rare,
    required int price,
    required String imageUrl,
    required int minRare,
    required int maxRare,
  }) = _Chest;

  factory Chest.fromJson(Map<String, dynamic> json) => _$ChestFromJson(json);

  @override
  T map<T>({required T Function(Character characher) characher, required T Function(Chest chest) chest}) => chest(this);
}
