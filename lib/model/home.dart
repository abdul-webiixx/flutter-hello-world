// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/review.dart';
import 'package:Zenith/model/upcoming.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel(
      {this.status,
      this.success,
      this.message,
      this.storagePath,
      this.homeData,
      this.requestStatus = RequestStatus.loading});

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final HomeData? homeData;
  RequestStatus requestStatus;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        storagePath: json["storage_path"],
        homeData: json["data"] != null ? HomeData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "storage_path": storagePath,
        "data": homeData != null ? homeData!.toJson() : null,
      };
}

class HomeData {
  HomeData(
      {this.greetings,
      this.danceCourses,
      this.instructors,
      this.upcomingLiveClasses,
      this.upcomingDemoClasses,
      this.reviews,
      this.danceClasses,
      this.pendingReviews,
      this.banner,
      this.workshop,
      this.advertisement,
      this.listWorkshop});

  final String? greetings;
  final List<DanceCourse>? danceCourses;
  final List<Instructor>? instructors;
  final List<DanceClass>? danceClasses;
  final List<UpcomingModel>? upcomingLiveClasses;
  final List<UpcomingModel>? upcomingDemoClasses;
  final List<ReviewDetails>? reviews;
  final List<BannerClass>? banner;
  final List<dynamic>? pendingReviews;
  final Workshop? workshop;
  final Advertisement? advertisement;
  final List<Workshop>? listWorkshop;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        greetings: json["greetings"],
        danceClasses: json["dance_classes"] != null
            ? List<DanceClass>.from(
                json["dance_classes"].map((x) => DanceClass.fromJson(x)))
            : null,
        danceCourses: json["dance_courses"] != null
            ? List<DanceCourse>.from(
                json["dance_courses"].map((x) => DanceCourse.fromJson(x)))
            : null,
        instructors: json["instructors"] != null
            ? List<Instructor>.from(
                json["instructors"].map((x) => Instructor.fromJson(x)))
            : null,
        upcomingLiveClasses: json["upcoming_live_classes"] != null
            ? List<UpcomingModel>.from(json["upcoming_live_classes"]
                .map((x) => UpcomingModel.fromJson(x)))
            : null,
        upcomingDemoClasses: json["upcoming_demo_classes"] != null
            ? List<UpcomingModel>.from(json["upcoming_demo_classes"]
                .map((x) => UpcomingModel.fromJson(x)))
            : null,
        reviews: json["reviews"] != null
            ? List<ReviewDetails>.from(
                json["reviews"].map((x) => ReviewDetails.fromJson(x)))
            : null,
        pendingReviews: json["pending_reviews"] != null
            ? List<dynamic>.from(json["pending_reviews"].map((x) => x))
            : null,
        banner: json["banner"] != null
            ? List<BannerClass>.from(
                json["banner"].map((x) => BannerClass.fromJson(x)))
            : null,
        workshop: json["workshop"] != null
            ? json["workshop"] is List
                ? null
                : Workshop.fromJson(json["workshop"])
            : null,
        advertisement: json["advertisement"] != null
            ? json["advertisement"] is List
                ? null
                : Advertisement.fromJson(json["advertisement"])
            : null,
        listWorkshop: json["workshop"] != null && json["workshop"] is List
            ? List<Workshop>.from(
                json["workshop"].map((x) => Workshop.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "greetings": greetings,
        "dance_classes": danceClasses != null
            ? List<dynamic>.from(danceClasses!.map((x) => x.toJson()))
            : null,
        "dance_courses": danceCourses != null
            ? List<dynamic>.from(danceCourses!.map((x) => x.toJson()))
            : null,
        "instructors": instructors != null
            ? List<dynamic>.from(instructors!.map((x) => x.toJson()))
            : null,
        "upcoming_live_classes": upcomingLiveClasses != null
            ? List<dynamic>.from(upcomingLiveClasses!.map((x) => x.toJson()))
            : null,
        "upcoming_demo_classes": upcomingDemoClasses != null
            ? List<dynamic>.from(upcomingDemoClasses!.map((x) => x.toJson()))
            : null,
        "reviews": reviews != null
            ? List<dynamic>.from(reviews!.map((x) => x.toJson()))
            : null,
      };
}

class Advertisement {
  String? title;
  String? description;
  String? cover;
  String? status;

  Advertisement({this.title, this.description, this.cover, this.status});

  Advertisement.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    cover = json['cover'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover'] = this.cover;
    data['status'] = this.status;
    return data;
  }
}

class DanceClass {
  DanceClass({
    this.id,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.icon,
  });

  final int? id;
  final String? name;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? description;
  final String? icon;

  factory DanceClass.fromJson(Map<String, dynamic> json) => DanceClass(
        id: json["id"],
        name: json["name"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        description: json["description"],
        icon: json["icon"] != null
            ? setStoragePath(imagePath: json["icon"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deleted_at": deletedAt,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "description": description,
        "icon": icon,
      };
}

class DanceCourse {
  DanceCourse({
    this.title,
    this.featuredImage,
    this.smallIcon,
    this.subTitle,
    this.tag,
    this.danceCourseItem,
  });

  final String? title;
  final String? featuredImage;
  final String? subTitle;
  final String? tag;
  final dynamic smallIcon;
  final List<DanceCourseItem>? danceCourseItem;

  factory DanceCourse.fromJson(Map<String, dynamic> json) => DanceCourse(
        title: json["title"],
        featuredImage: json["featured_image"],
        smallIcon: json["small_icon"] != null
            ? setStoragePath(imagePath: json["small_icon"])
            : null,
        subTitle: json["sub_title"],
        tag: json["tag"],
        danceCourseItem: json["data"] != null
            ? List<DanceCourseItem>.from(
                json["data"].map((x) => DanceCourseItem.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sub_title": subTitle,
        "featured_image": featuredImage,
        "small_icon": smallIcon,
        "tag": tag,
        "data": List<dynamic>.from(danceCourseItem!.map((x) => x.toJson())),
      };
}

class BannerClass {
  BannerClass({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.sequence,
    this.name,
    this.items,
  });

  final int? id;
  final dynamic type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic sequence;
  final String? name;
  final List<BannerItem>? items;

  factory BannerClass.fromJson(Map<String, dynamic> json) => BannerClass(
        id: json["id"],
        type: json["type"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        sequence: json["sequence"],
        name: json["name"],
        items: json["items"] != null
            ? List<BannerItem>.from(
                json["items"].map((x) => BannerItem.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "sequence": sequence,
        "name": name,
        "items": items != null
            ? List<dynamic>.from(items!.map((x) => x.toJson()))
            : null,
      };
}

class BannerItem {
  BannerItem({
    this.id,
    this.bannerId,
    this.type,
    this.path,
    this.createdAt,
    this.updatedAt,
    this.action,
    this.name,
    this.sequence,
  });

  final int? id;
  final int? bannerId;
  final String? type;
  final String? path;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic action;
  final String? name;
  final int? sequence;

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        id: json["id"],
        bannerId: json["banner_id"],
        type: json["type"],
        path: json["path"] != null
            ? setStoragePath(imagePath: json["path"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        action: json["action"],
        name: json["name"],
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_id": bannerId,
        "type": type,
        "path": path,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "action": action,
        "name": name,
        "sequence": sequence,
      };
}

class Workshop {
  Workshop(
      {this.id,
      this.name,
      this.details,
      this.date,
      this.time,
      this.datetime,
      this.duration,
      this.image,
      this.instructor,
      this.uuid,
      this.meetingId,
      this.hostId,
      this.hostEmail,
      this.status,
      this.startUrl,
      this.joinUrl,
      this.timezone,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.isTaxable,
      this.taxClassId,
      this.productType,
      this.price,
      this.productId,
    //  this.subscription,
      this.start_time,
      this.end_time,
      this.day,
      this.month,
      this.service_name,
          this.subscription,
          this.current_subscription,
      });

  final int? id;
  final String? name;
  final String? details;
  final DateTime? date;
  final String? time;
  final dynamic datetime;
  //  final dynamic end_time;
  final int? duration;
  final String? image;
  final int? instructor;
  final String? uuid;
  final String? meetingId;
  final String? hostId;
  final String? hostEmail;
  final String? status;
  final String? startUrl;
  final String? joinUrl;
  final dynamic timezone;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? isTaxable;
  final dynamic taxClassId;
  final int? productType;
  final int? price;
  final int? productId;
  // final String? subscription;
  // String? subscription;
  var start_time;
  final dynamic end_time;
  final dynamic day;
  final String? month;
  final String? service_name;
  // final int? package_id;
  final String? subscription;
    final String? current_subscription;

  factory Workshop.fromJson(Map<String, dynamic> json) => Workshop(
      id: json["id"],
      name: json["name"],
      details: json["details"],
      date: DateTime.parse(json["date"]),
      //  end_time: DateTime.parse(json["end_time"]),
      time: json["time"],
      datetime: json["datetime"],
      duration: json["duration"],
      image: json["image"] != null ? setStoragePath(imagePath: json["image"]): null,
      instructor: json["instructor"],
      uuid: json["uuid"],
      meetingId: json["meeting_id"],
      hostId: json["host_id"],
      hostEmail: json["host_email"],
      status: json["status"],
      startUrl: json["start_url"],
      joinUrl: json["join_url"],
      timezone: json["timezone"],
      password: json["password"],
      createdAt: DateTime.parse(json["created_at"]),
       updatedAt: json["updated_at"] != null  ? DateTime.parse(json["updated_at"]) : null,
      isTaxable: json["is_taxable"],
      taxClassId: json["tax_class_id"],
      productType: json["product_type"],
      price: json["price"],
      productId: json["product_id"],
      // subscription: json["subscription"],
       start_time:  json["start_time"] != null ? DateTime.parse(json["start_time"]) : null,
         end_time:  json["end_time"] != null ? DateTime.parse(json["end_time"]): null,
          day: json["day"],
           month: json["month"],
            //  subscription: json["subscription"]!=null? json["subscription"]:"Null",
             service_name: json["service_name"] !=null? json["service_name"]:"Null",
              subscription: json["subscription"],
                current_subscription: json["current_subscription"] !=null? json["current_subscription"]:"Null",
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": details,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      
        "time": time,
        "datetime": datetime,
        "duration": duration,
        "image": image,
        "instructor": instructor,
        "uuid": uuid,
        "meeting_id": meetingId,
        "host_id": hostId,
        "host_email": hostEmail,
        "status": status,
        "start_url": startUrl,
        "join_url": joinUrl,
        "timezone": timezone,
        "password": password,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "is_taxable": isTaxable,
        "tax_class_id": taxClassId,
        "product_type": productType,
        "price": price,
        "product_id": productId,
        // "subscription": subscription,
        "start_time":start_time != null ? start_time!.toIso8601String() : null,
        "end_time": end_time != null ? end_time!.toIso8601String() : null,
        "day":day,
        "month":month,
        "service_name":service_name,
        "subscription":subscription,
        "current_subscription":current_subscription
        
      };
}

class DanceCourseItem {
  DanceCourseItem({
    this.sectionItemId,
    this.courseId,
    this.packageId,
    this.lessonId,
    this.image,
  });

  final int? sectionItemId;
  final int? courseId;
  final int? packageId;
  final int? lessonId;
  final String? image;

  factory DanceCourseItem.fromJson(Map<String, dynamic> json) =>
      DanceCourseItem(
        sectionItemId: json["section_item_id"],
        courseId: json["course_id"],
        packageId: json["package_id"],
        lessonId: json["lesson_id"],
        image: json["image"] != null
            ? setStoragePath(imagePath: json["image"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "section_item_id": sectionItemId,
        "course_id": courseId,
        "package_id": packageId,
        "lesson_id": lessonId,
        "image": image,
      };
}

class Instructor {
  Instructor(
      {this.id,
      this.name,
      this.avatar,
      this.danceForm,
      this.classes,
      this.totalRatings});

  final int? id;
  final String? name;
  final String? avatar;
  final String? danceForm;
  final dynamic totalRatings;
  final int? classes;

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"] != null
            ? setStoragePath(imagePath: json["avatar"])
            : null,
        danceForm: json["dance_forms"],
        totalRatings: json["total_ratings"],
        classes: json["classes"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "dance_form": danceForm,
        "total_ratings": totalRatings,
        "classes": classes
      };
}
