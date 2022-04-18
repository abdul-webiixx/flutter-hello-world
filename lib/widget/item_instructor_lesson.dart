import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/instructor_lesson.dart';
import 'package:Zenith/screen/add_course.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/video_player_preview.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ItemInstructorLesson extends StatefulWidget {
  final InstructorLessonDetails instructorLessonDetails;
  final int index;
  final Key? trailingKey;
  final Key? previewKey;
  final Key? editKey;
  final Key? deleteKey;
  final GestureTapCallback? onDeleteTap;
  const ItemInstructorLesson(
      {Key? key,
      required this.instructorLessonDetails,
      required this.trailingKey,
      required this.previewKey,
      this.onDeleteTap,
      this.deleteKey,
      this.editKey,
      required this.index})
      : super(key: key);

  @override
  _ItemInstructorLessonState createState() => _ItemInstructorLessonState();
}

class _ItemInstructorLessonState extends State<ItemInstructorLesson> {
  late VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: widget.key,
      color: Theme.of(context).highlightColor,
      elevation: 4,
      child: ListTile(
        leading: InkWell(
          onTap: () {
            if (widget.instructorLessonDetails.videoUrl != null) {
              _videoPlayerController = VideoPlayerController.network(
                  widget.instructorLessonDetails.videoUrl)
                ..initialize().then((value) => _videoPlayerController.play());
              videoPlayerDialog(context, _videoPlayerController);
            } else {
              showToast(context, msg: "Video url not found");
            }
          },
          child: Container(
              key: widget.previewKey,
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                  color: black, borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.instructorLessonDetails.thumbnail ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Image.asset(
                    moke_image4,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ),
        title: InkWell(
          onTap: () {
            changeScreen(
                context,
                AddNewCourses(
                  instructorLessonDetails: widget.instructorLessonDetails,
                ));
          },
          onLongPress: widget.onDeleteTap,
          onDoubleTap: widget.onDeleteTap,
          child: Text(
            "${widget.instructorLessonDetails.title!}",
            key: widget.editKey,
            maxLines: 2,
            style: styleProvider(),
          ),
        ),
        subtitle: Text(
          "${widget.instructorLessonDetails.description!}",
          key: widget.deleteKey,
          maxLines: 2,
          style: styleProvider(color: grey, size: 10),
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 5),
          key: widget.trailingKey,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            "${widget.index.toString().padLeft(2, "0")}",
            style: styleProvider(
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
// InkWell(
// key: widget.deleteKey,
// onTap: widget.onDeleteTap,
// child: Icon(
// Icons.close,size: 30, color: Theme.of(context).errorColor.withOpacity(0.3),),
// )
