
class OtherInformation {
  OtherInformation({
    this.totalComments,
    this.totalLikes,
    this.totalViews,
  });

  final int? totalComments;
  final int? totalLikes;
  final int? totalViews;

  factory OtherInformation.fromJson(Map<String, dynamic> json) => OtherInformation(
    totalComments: json["total_comments"],
    totalLikes: json["total_likes"],
    totalViews: json["total_views"],
  );

  Map<String, dynamic> toJson() => {
    "total_comments": totalComments,
    "total_likes": totalLikes,
    "total_views": totalViews,
  };
}