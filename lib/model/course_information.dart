
class CourseInformation {
  CourseInformation({
    this.title,
    this.id,
    this.featuredImage,
    this.lessons,
    this.classes,
    this.description,
    this.duration,
    this.durationUnit,
    this.previewLesson,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.videoUrl,
    this.libraryId,
    this.courseId,
    this.packageId,
    this.sectionItemId,
    this.isLiked
  });

  final String? title;
  final int? id;
  final String? featuredImage;
  final int? lessons;
  final int? classes;
  final String? description;
  final int? duration;
  final String? durationUnit;
  final int? previewLesson;
  final String? status;
  final int? createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic videoUrl;
  final int? libraryId;
  final int? courseId;
  final int? packageId;
  final int? sectionItemId;
  final bool? isLiked;

  factory CourseInformation.fromJson(Map<String, dynamic> json) => CourseInformation(
    title: json["title"],
    id: json["id"],
    featuredImage: json["featured_image"],
    lessons: json["lessons"],
    description: json["description"],
    classes: json["classes"],
    duration: json["duration"],
    durationUnit: json["duration_unit"],
    previewLesson: json["preview_lesson"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]!=null ?
    DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ?
    DateTime.parse(json["updated_at"]) : null,
    videoUrl: json["video_url"],
    libraryId: json["library_id"],
    courseId: json["course_id"],
    packageId: json["package_id"],
    sectionItemId: json["section_item_id"],
    isLiked: json["is_liked"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "featured_image": featuredImage,
    "lessons": lessons,
    "classes": classes,
    "duration": duration,
    "duration_unit": durationUnit,
    "preview_lesson": previewLesson,
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "video_url": videoUrl,
    "library_id": libraryId,
    "course_id": courseId,
    "package_id": packageId,
    "section_item_id": sectionItemId,
    "is_liked":isLiked
  };
}
