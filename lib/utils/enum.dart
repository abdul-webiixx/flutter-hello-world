
enum ViewState { Idle, Busy }
enum ValidationFor { Login, SignUp, Mobile, EditProfile, Attendance }
enum RequestStatus { initial, loading, loaded, unauthorized, server, network, failure}
enum ResponseStatus { unauthorized, server, network, failed}
enum UserStatus { Unauthorized, Authorized, Processing }
enum UserType { Trainer, Student }
enum AppStatus { Update, Maintenance, Running }
enum PolicyRequestFor { AboutUs, PrivacyPolicy, TermsAndUse }
enum OtpFor { Login, ForgotPassword, SignUp, Email }
enum ShimmerFor { InstructorHome,CourseScreen, Choreography, Home}
enum ThanksFor {SignUp, Purchase}