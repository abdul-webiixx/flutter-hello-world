import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'course_information.dart';

InstructorLessonModel instructorLessonModelFromJson(String str) => InstructorLessonModel.fromJson(json.decode(str));

String instructorLessonModelToJson(InstructorLessonModel data) => json.encode(data.toJson());

class InstructorLessonModel {
  InstructorLessonModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.instructorLessonDetails,
    this.courseInformation,
    this.requestStatus = RequestStatus.loading
  });
  
  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final CourseInformation? courseInformation;
  final List<InstructorLessonDetails>? instructorLessonDetails;
  RequestStatus requestStatus;

  factory InstructorLessonModel.fromJson(Map<String, dynamic> json) => InstructorLessonModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    courseInformation: json["course_information"]!=null ?
    CourseInformation.fromJson(json["course_information"]) : null,

    storagePath: json["storage_path"],
    instructorLessonDetails: List<InstructorLessonDetails>.from(json["data"].map((x) => InstructorLessonDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": instructorLessonDetails!=null ? List<dynamic>.from(instructorLessonDetails!.map((x) => x.toJson())) : null,
  };
}

class InstructorLessonDetails {
  InstructorLessonDetails({
    this.id,
    this.title,
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
    this.choreographyId,
    this.thumbnail,
    this.videoId,
    this.sequence,
    this.instructorId,
    this.approval,
    this.courseName,
    this.choreographyName,
  });

  final int? id;
  final String? title;
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
  final dynamic libraryId;
  final int? courseId;
  final int? choreographyId;
  final dynamic thumbnail;
  final String? videoId;
  final dynamic sequence;
  final int? instructorId;
  final String? approval;
  final dynamic courseName;
  final dynamic choreographyName;

  factory InstructorLessonDetails.fromJson(Map<String, dynamic> json) => InstructorLessonDetails(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    duration: json["duration"],
    durationUnit: json["duration_unit"],
    previewLesson: json["preview_lesson"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]): null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]): null,
    videoUrl: json["video_url"],
    libraryId: json["library_id"],
    courseId: json["course_id"],
    choreographyId: json["choreography_id"],
    thumbnail: json["thumbnail"],
    videoId: json["video_id"] == null ? null : json["video_id"],
    sequence: json["sequence"],
    instructorId: json["instructor_id"],
    approval: json["approval"],
    courseName: json["course_name"],
    choreographyName: json["choreography_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
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
    "choreography_id": choreographyId,
    "thumbnail": thumbnail,
    "video_id": videoId == null ? null : videoId,
    "sequence": sequence,
    "instructor_id": instructorId,
    "approval": approval,
    "course_name": courseName,
    "choreography_name": choreographyName,
  };
}