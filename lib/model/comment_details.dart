import 'package:Zenith/constants/app_constants.dart';

class Comment {
  Comment({
    this.id,
    this.parentId,
    this.comment,
    this.commentFor,
    this.isApproved,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.packageId,
    this.lessonId,
    this.name,
    this.avatar,
  });

  final int? id;
  final int? parentId;
  final String? comment;
  final String? commentFor;
  final bool? isApproved;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? packageId;
  final int? lessonId;
  final String? name;
  final String? avatar;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    parentId: json["parent_id"],
    comment: json["comment"],
    commentFor: json["comment_for"],
    isApproved: json["is_approved"],
    userId: json["user_id"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    packageId: json["package_id"],
    lessonId: json["lesson_id"],
    name: json["name"],
    avatar: json["avatar"]!=null ? setStoragePath(imagePath: json["avatar"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "comment": comment,
    "comment_for": commentFor,
    "is_approved": isApproved,
    "user_id": userId,
    "created_at": createdAt !=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "package_id": packageId,
    "lesson_id": lessonId,
    "name": name,
    "avatar": avatar,
  };
}