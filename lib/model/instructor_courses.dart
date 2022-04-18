// import 'package:Zenith/utils/enum.dart';

// class InstructorCoursesModel {
//   int? status;
//   bool? success;
//   String? message;
//   String? storagePath;
//   List<Data>? data;

//    RequestStatus requestStatus;

//   InstructorCoursesModel(
//       {this.status, this.success, this.message, this.storagePath, this.data, this.requestStatus = RequestStatus.loading});

//   InstructorCoursesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     success = json['success'];
//     message = json['message'];
//     storagePath = json['storage_path'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['success'] = this.success;
//     data['message'] = this.message;
//     data['storage_path'] = this.storagePath;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? title;
//   String? description;
//   int? blockOnExpire;
//   int? blockOnFinish;
//   int? maxAllowedStudents;
//   int? featured;
//   Null? externalLink;
//   int? enrolledStudent;
//   int? reTakenCourse;
//   String? status;
//   int? createdBy;
//   Null? updateBy;
//   Null? deletedBy;
//   Null? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   int? allowRePurchase;
//   String? featuredImage;
//   Null? pricing;
//   int? isTaxable;
//   int? taxClassesId;
//   String? smallIcon;
//   int? instructor;
//   int? courseId;
//   int? instructorId;
//   String? name;
//   String? image;
//   String? libraryId;

//   Data(
//       {this.id,
//       this.title,
//       this.description,
//       this.blockOnExpire,
//       this.blockOnFinish,
//       this.maxAllowedStudents,
//       this.featured,
//       this.externalLink,
//       this.enrolledStudent,
//       this.reTakenCourse,
//       this.status,
//       this.createdBy,
//       this.updateBy,
//       this.deletedBy,
//       this.deletedAt,
//       this.createdAt,
//       this.updatedAt,
//       this.allowRePurchase,
//       this.featuredImage,
//       this.pricing,
//       this.isTaxable,
//       this.taxClassesId,
//       this.smallIcon,
//       this.instructor,
//       this.courseId,
//       this.instructorId,
//       this.name,
//       this.image,
//       this.libraryId});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     blockOnExpire = json['block_on_expire'];
//     blockOnFinish = json['block_on_finish'];
//     maxAllowedStudents = json['max_allowed_students'];
//     featured = json['featured'];
//     externalLink = json['external_link'];
//     enrolledStudent = json['enrolled_student'];
//     reTakenCourse = json['re_taken_course'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     updateBy = json['update_by'];
//     deletedBy = json['deleted_by'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     allowRePurchase = json['allow_re_purchase'];
//     featuredImage = json['featured_image'];
//     pricing = json['pricing'];
//     isTaxable = json['is_taxable'];
//     taxClassesId = json['tax_classes_id'];
//     smallIcon = json['small_icon'];
//     instructor = json['instructor'];
//     courseId = json['course_id'];
//     instructorId = json['instructor_id'];
//     name = json['name'];
//     image = json['image'];
//     libraryId = json['library_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['block_on_expire'] = this.blockOnExpire;
//     data['block_on_finish'] = this.blockOnFinish;
//     data['max_allowed_students'] = this.maxAllowedStudents;
//     data['featured'] = this.featured;
//     data['external_link'] = this.externalLink;
//     data['enrolled_student'] = this.enrolledStudent;
//     data['re_taken_course'] = this.reTakenCourse;
//     data['status'] = this.status;
//     data['created_by'] = this.createdBy;
//     data['update_by'] = this.updateBy;
//     data['deleted_by'] = this.deletedBy;
//     data['deleted_at'] = this.deletedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['allow_re_purchase'] = this.allowRePurchase;
//     data['featured_image'] = this.featuredImage;
//     data['pricing'] = this.pricing;
//     data['is_taxable'] = this.isTaxable;
//     data['tax_classes_id'] = this.taxClassesId;
//     data['small_icon'] = this.smallIcon;
//     data['instructor'] = this.instructor;
//     data['course_id'] = this.courseId;
//     data['instructor_id'] = this.instructorId;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['library_id'] = this.libraryId;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final instructorCoursesModel = instructorCoursesModelFromJson(jsonString);

import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

InstructorCoursesModel instructorCoursesModelFromJson(String str) => InstructorCoursesModel.fromJson(json.decode(str));

String instructorCoursesModelToJson(InstructorCoursesModel data) => json.encode(data.toJson());


class InstructorCoursesModel {
    InstructorCoursesModel({
     this.status,
     this.success,
     this.message,
     this.storagePath,
     this.data,
  this.requestStatus = RequestStatus.loading
    });

    int? status;
    bool? success;
    String? message;
    String? storagePath;
    List<Datum>? data;
    RequestStatus requestStatus;

    

    factory InstructorCoursesModel.fromJson(Map<String, dynamic> json) => InstructorCoursesModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        storagePath: json["storage_path"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "storage_path": storagePath,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
     this.id,
     this.title,
     this.description,
     this.blockOnExpire,
     this.blockOnFinish,
     this.maxAllowedStudents,
     this.featured,
     this.externalLink,
     this.enrolledStudent,
     this.reTakenCourse,
     this.status,
     this.createdBy,
     this.updateBy,
     this.deletedBy,
     this.deletedAt,
     this.createdAt,
     this.updatedAt,
     this.allowRePurchase,
     this.featuredImage,
     this.pricing,
     this.isTaxable,
     this.taxClassesId,
     this.smallIcon,
     this.instructor,
     this.courseId,
     this.instructorId,
     this.name,
     this.image,
     this.libraryId,
    });

    int? id;
    String? title;
    String? description;
    int? blockOnExpire;
    int? blockOnFinish;
    int? maxAllowedStudents;
    int? featured;
    dynamic externalLink;
    int? enrolledStudent;
    int? reTakenCourse;
    String? status;
    int? createdBy;
    dynamic updateBy;
    dynamic deletedBy;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? allowRePurchase;
    String? featuredImage;
    dynamic pricing;
    int? isTaxable;
    int? taxClassesId;
    String? smallIcon;
    int? instructor;
    int? courseId;
    int? instructorId;
    String? name;
    String? image;
    String? libraryId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        blockOnExpire: json["block_on_expire"],
        blockOnFinish: json["block_on_finish"],
        maxAllowedStudents: json["max_allowed_students"],
        featured: json["featured"],
        externalLink: json["external_link"],
        enrolledStudent: json["enrolled_student"],
        reTakenCourse: json["re_taken_course"],
        status: json["status"],
        createdBy: json["created_by"],
        updateBy: json["update_by"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        allowRePurchase: json["allow_re_purchase"],
        featuredImage: json["featured_image"]!=null ? setStoragePath(imagePath: json["featured_image"]) : null,
        pricing: json["pricing"],
        isTaxable: json["is_taxable"],
        taxClassesId: json["tax_classes_id"],
        smallIcon: json["small_icon"],
        instructor: json["instructor"],
        courseId: json["course_id"],
        instructorId: json["instructor_id"],
        name: json["name"],
        image: json["image"]!=null ? setStoragePath(imagePath: json["image"]) : null,
        libraryId: json["library_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "block_on_expire": blockOnExpire,
        "block_on_finish": blockOnFinish,
        "max_allowed_students": maxAllowedStudents,
        "featured": featured,
        "external_link": externalLink,
        "enrolled_student": enrolledStudent,
        "re_taken_course": reTakenCourse,
        "status": status,
        "created_by": createdBy,
        "update_by": updateBy,
        "deleted_by": deletedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "allow_re_purchase": allowRePurchase,
        "featured_image": featuredImage,
        "pricing": pricing,
        "is_taxable": isTaxable,
        "tax_classes_id": taxClassesId,
        "small_icon": smallIcon,
        "instructor": instructor,
        "course_id": courseId,
        "instructor_id": instructorId,
        "name": name,
        "image": image,
        "library_id": libraryId,
    };
}
