class VideoModel {
  VideoModel({
    this.videoAnimationUrl,
    this.videoThumb,
    this.videoUrlEmbed,
    this.videoUrl,
    this.videoWebUrl
  });

  final String? videoAnimationUrl;
  final String? videoThumb;
  final String? videoUrlEmbed;
  final String? videoUrl;
  final String? videoWebUrl;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    videoAnimationUrl: json["video_animation_url"],
    videoThumb: json["video_thumb"],
    videoUrlEmbed: json["video_url_embed"],
    videoUrl: json["video_url"],
    videoWebUrl: json["video_web_url"]
  );

  Map<String, dynamic> toJson() => {
    "video_animation_url": videoAnimationUrl,
    "video_thumb": videoThumb,
    "video_url_embed": videoUrlEmbed,
    "video_url": videoUrl,
    "video_web_url":videoWebUrl
  };
}