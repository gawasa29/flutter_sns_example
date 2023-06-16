// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEntity _$$_UserEntityFromJson(Map<String, dynamic> json) =>
    _$_UserEntity(
      name: json['name'] as String,
      userId: json['userId'] as String,
      bio: json['bio'] as String,
      profilePic: json['profilePic'] as String,
      followerNum: json['followerNum'] as int,
      followingNum: json['followingNum'] as int,
    );

Map<String, dynamic> _$$_UserEntityToJson(_$_UserEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'bio': instance.bio,
      'profilePic': instance.profilePic,
      'followerNum': instance.followerNum,
      'followingNum': instance.followingNum,
    };
