/*-------------App Constants-----------*/

import 'package:Zenith/utils/enum.dart';
import 'package:flutter/cupertino.dart';

const String authToken = "auth_token";
const String userId = "user_id";
const String lessonCache = "lessonCache";
const String addLessonCache = "addLessonCache";
const String userType = "user_type";
const String appName = 'Zenith';
const String appDes = 'A dance tutorial app';
const String fontName = 'Poppins';
const String app_Theme = 'app_theme';
const String dark_Mode = 'dark_mode';
const String deviceToken = 'device_token';
const String userModel = "userModel";
const String light_Mode = 'light_mode';
const String indian_flag =
    'https://cdn.britannica.com/97/1597-004-05816F4E/Flag-India.jpg';
const String videoUrl = '';

/*----------Error Massage----------------------*/
const String network_error = 'Something Went Wrong';
const String data_not_found = 'Data Not Found';
const String login_status_failed = 'User Login Failed';
const String login_status_success = 'User Login Successfully';
const String email_not_found = 'Email Id Not Found';
const String user_not_found = 'User Not Found';
const String select_attendance = 'Kindly fill your attendance';
const String enter_user_name =
    'please enter a valid name & name should not include any digit and spacial character';
const String enter_user_email = 'please enter a valid email';
const String enter_student_id = 'please enter a valid student id';
const String enter_user_mobile = 'please enter a valid mobile no';
const String enter_user_address = 'please enter a valid address';
const String select_gender = 'please select gender';
const String enter_user_dob = 'please enter a valid birth date';
const String logout_user = 'Logout Successfully';
const String enter_otp = 'Please Enter OTP';
const String login_details = 'Enter your login credentials';
const String enter_user_password = 'Please Enter 6 digit valid password';
const String enter_user_conf_password = 'Password not match';
const String accept_terms_n_cond = 'Please check Remember me to keep login';
const String in_complete_password_error =
    'Please Enter a Valid 6 digit password';
const String in_complete_email_error = 'Please Enter a Valid Email Id';
const String in_complete_name_error = 'Please Enter a Valid Email Id';
const String in_complete_address1_error = 'Please enter address 1';
const String in_complete_address2_error = 'Please enter address 2';
const String in_complete_city_error = 'Please enter a city name';
const String in_complete_state_error = 'Please select your state';
const String in_complete_zip_error = 'Please Enter a Valid Zip Code';
const String incorrect_number = 'Incorrect Number';
const String incorrect_amount = 'Incorrect amount';
const String above_100_amount = 'Entered amount must be above 100';
const String incorrect_ifsc = 'Enter a valid IFSC code';
const String incorrect_account = 'Enter a valid Account no';
const String accept_policy = 'Please accept our policy';
const String select_state = 'Please select state code';

const String enter_lesson_title = 'Please enter a valid lesson title';
const String enter_lesson_name = 'Please enter a valid lesson name';
const String enter_lesson_caption = 'Please enter a valid lesson caption';
const String add_video = 'Please add your video';
const String select_choreography = 'Please select your choreography';
const String internet_connection_error =
    "Please check your internet connection or try re-open application.";
const String authentication_failed =
    "Authentication failed, User data not found...";
const String request_error_msg =
    "Your request getting failed, please try again after some time...";
const String ConnectionRequestFailed =
    "Connection Request getting failed, kindly try after some time";
const String no_center_found = "Offline Center Not Found";
const String in_complete_review = "Review can not be empty";
const String in_complete_rating = "Please give some rating";

const String typeDiploma = "Diploma";
const int https_code_200 = 200;
const int https_code_201 = 201;
const int https_code_404 = 404;
const int https_code_401 = 401;
const int https_code_500 = 500;
const int https_code_502 = 502;
const int https_code_504 = 504;
const String dummyMail = "user@mail.com";
const String dummyDOB = "2000-01-01";
const String dummyUser = "user";
DateTime dummyDate = DateTime.parse("2021-01-01 00:00:00.000Z");
const String thumbnail_user_home =
    "https://res.cloudinary.com/dyfmmvydb/image/upload/v1643289908/PicsArt_01-27-06.48.03_1_tmv4nq.jpg";
const String thumbnail_user =
    "https://secure.gravatar.com/avatar/0ebdca653970c966ce5e8bf84a1d0a5a?s=96&d=mm&r=g";

const String loader_path =
    "https://media3.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif";

const String video_thumb_url =
    "https://images.pexels.com/photos/1701195/pexels-photo-1701195.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
/*-----------------IC_Images_Assets--------------------*/
const String ic_bg_splash = "assets/images/ic_bgSplash.png";
const String ic_logo = "assets/images/ic_launcher.png";
const String ic_thank_you = "assets/images/ic_thankYou.png";
const String ic_thankYou_signUp = "assets/images/ic_thankYou_signUp.png";
const String ic_dance_girl = "assets/images/ic_dancer_girl.png";
const String ic_warning = "assets/images/ic_warning.png";
const String ic_razorpay = "assets/images/ic_razorpay.png";
const String ic_sort_arrow = "assets/images/ic_sort_arrow.png";
const String ic_maintenance = "assets/images/ic_maintenance.png";
const String ic_update = "assets/images/ic_update.png";
const String ic_data_not_found = "assets/images/ic_dataNotFound.png";
const String ic_generic_png = "assets/images/ic_generic.png";
const String dummy_image_url =
    "https://dance.themiixx.com/storage/service-types/June2021/wwF8JNqClwjSl1xBHKiA.png";
const String ic_notification_logo = "assets/images/ic_notification_logo.png";

/*-----------------IC_SVG_Assets--------------------*/
const String ic_arrow = "assets/icons/ic_arrow.svg";
const String ic_generic_svg = "assets/icons/ic_generic.svg";
const String ic_offline = "assets/icons/ic_offline_class.svg";
const String ic_play = "assets/icons/ic_play.svg";
const String ic_vplay = "assets/icons/ic_vplay.svg";
const String ic_trms = "assets/icons/ic_term_n_condition.svg";
const String ic_close = "assets/icons/ic_close.svg";
const String ic_chat = "assets/icons/ic_chat.svg";
const String ic_subscriptions = "assets/icons/ic_subscriptions.svg";
const String ic_chatforcontact = "assets/icons/ic_chatforcontact.svg";

const String ic_certificate = "assets/icons/ic_certificate.svg";
const String ic_fitness = "assets/icons/ic_fitness.svg";
const String ic_dancer = "assets/icons/ic_dancer.svg";
const String ic_lock = "assets/icons/ic_lock.svg";
/*-----------------SizeBuilder---------------------------*/
const double dp5 = 5.0;
const double dp10 = 10.0;
const double dp15 = 15.0;
const double dp20 = 20.0;
const double dp25 = 25.0;
const double dp30 = 30.0;
const double dp35 = 35.0;
const double dp40 = 40.0;
const double dp45 = 45.0;
const double dp50 = 50.0;
const double dp55 = 55.0;
const double dp60 = 60.0;
const double dp65 = 65.0;
const double dp70 = 70.0;
const double dp75 = 75.0;
const double dp80 = 80.0;
const double dp85 = 85.0;
const double dp90 = 90.0;
const double dp95 = 95.0;
const double dp100 = 100.0;

/*-------------------FontWeight-------------------------*/
const FontWeight thin = FontWeight.w100;
const FontWeight extraLight = FontWeight.w200;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight dark = FontWeight.w900;

/*-----------------Mobile Screen Text--------------------*/
const String otp_text_code =
    "Add your phone number. we'll send you a verification code so we know you're real.";
const String otp_text_terms =
    "By providing my phone number, I hereby agree and accept the Term of Service and Privacy Policy in use of the zenith Dance App";

/*-----------------Mobile Screen Text--------------------*/
const String moke_image1 = "assets/mokedata/image1.png";
const String moke_image2 = "assets/mokedata/image2.png";
const String moke_image3 = "assets/mokedata/image3.png";
const String moke_image4 = "assets/mokedata/image4.png";

/*--------------------Chat link-------------------------------*/
const String direct_chat_link =
    "https://tawk.to/chat/60f55636d6e7610a49abf5eb/1fav5hhr3";

/*--------------------Razor App Key-------------------------------*/
const String razorpayUrl = "https://dashboard.razorpay.com/img/logo_full.png";

const String zoom_domain = "zoom.us";
const String zoom_app_key = "5h0asRx0BPUoQXHa70QgM3LWVF2oxo6szzPg";
const String zoom_app_secret = "zDbZJ5GJw2ScXZhwgHY1fz0uCxwqMKIDVUcN";

String homeStoragePath = "";

UserType setUserType = UserType.Student;

String setStoragePath({required String imagePath}) {
  return homeStoragePath + imagePath;
}
