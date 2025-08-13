// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterImpl _$$CharacterImplFromJson(Map<String, dynamic> json) =>
    _$CharacterImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      rare: (json['rare'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      isArtificialSpecs: json['isArtificialSpecs'] as bool,
      leftRatings: (json['leftRatings'] as num).toInt(),
      spec1: (json['spec1'] as num).toInt(),
      spec2: (json['spec2'] as num).toInt(),
      spec3: (json['spec3'] as num).toInt(),
      spec4: (json['spec4'] as num).toInt(),
      spec5: (json['spec5'] as num).toInt(),
    );

Map<String, dynamic> _$$CharacterImplToJson(_$CharacterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rare': instance.rare,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'isArtificialSpecs': instance.isArtificialSpecs,
      'leftRatings': instance.leftRatings,
      'spec1': instance.spec1,
      'spec2': instance.spec2,
      'spec3': instance.spec3,
      'spec4': instance.spec4,
      'spec5': instance.spec5,
    };

_$ChestImpl _$$ChestImplFromJson(Map<String, dynamic> json) => _$ChestImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  rare: (json['rare'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  minRare: (json['minRare'] as num).toInt(),
  maxRare: (json['maxRare'] as num).toInt(),
);

Map<String, dynamic> _$$ChestImplToJson(_$ChestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rare': instance.rare,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'minRare': instance.minRare,
      'maxRare': instance.maxRare,
    };
