// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_git_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGitResponse _$UserGitResponseFromJson(Map<String, dynamic> json) {
  return UserGitResponse(
    (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : UserGitEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserGitResponseToJson(UserGitResponse instance) =>
    <String, dynamic>{
      'items': instance.userGits,
    };
