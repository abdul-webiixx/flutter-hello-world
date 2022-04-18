class AllInstructorsModel {
  int ?status;
  bool ?success;
  String? message;
  String? storagePath;
  Data? data;

  AllInstructorsModel(
      {this.status, this.success, this.message, this.storagePath, this.data});

  AllInstructorsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    storagePath = json['storage_path'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    data['storage_path'] = this.storagePath;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<SubData>? subdata;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links> ?links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.subdata,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      subdata = <SubData>[];
      json['data'].forEach((v) {
        subdata!.add(new SubData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.subdata != null) {
      data['data'] = this.subdata!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class SubData {
  int? id;
  int? roleId;
  String ?name;
  String ?email;
  String ?avatar;
  var emailVerifiedAt;
  // List<Null> settings;
  String? createdAt;
  String? updatedAt;
  var stripeId;
  var cardBrand;
  var cardLastFour;
  var trialEndsAt;
  String? zoomUserId;
  String? address1;
  String? address2;
  String? city;
  int? state;
  String? zip;
  String? dob;
  var emailOtp;
  int ?isEmailVerified;
  String ?gender;
  String ?mobile;
  String ?status;
  var libraryId;
  var libraryName;
  var libraryApiKey;
  var libraryApiKeyReadOnly;
  var libraryPullZoneId;
  var libraryPullZoneName;

  SubData(
      {this.id,
      this.roleId,
      this.name,
      this.email,
      this.avatar,
      this.emailVerifiedAt,
      // this.settings,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.zoomUserId,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.dob,
      this.emailOtp,
      this.isEmailVerified,
      this.gender,
      this.mobile,
      this.status,
      this.libraryId,
      this.libraryName,
      this.libraryApiKey,
      this.libraryApiKeyReadOnly,
      this.libraryPullZoneId,
      this.libraryPullZoneName});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
    zoomUserId = json['zoom_user_id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    dob = json['dob'];
    emailOtp = json['email_otp'];
    isEmailVerified = json['is_email_verified'];
    gender = json['gender'];
    mobile = json['mobile'];
    status = json['Status'];
    libraryId = json['library_id'];
    libraryName = json['library_name'];
    libraryApiKey = json['library_api_key'];
    libraryApiKeyReadOnly = json['library_api_key_read_only'];
    libraryPullZoneId = json['library_pull_zone_id'];
    libraryPullZoneName = json['library_pull_zone_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    data['zoom_user_id'] = this.zoomUserId;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['dob'] = this.dob;
    data['email_otp'] = this.emailOtp;
    data['is_email_verified'] = this.isEmailVerified;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['Status'] = this.status;
    data['library_id'] = this.libraryId;
    data['library_name'] = this.libraryName;
    data['library_api_key'] = this.libraryApiKey;
    data['library_api_key_read_only'] = this.libraryApiKeyReadOnly;
    data['library_pull_zone_id'] = this.libraryPullZoneId;
    data['library_pull_zone_name'] = this.libraryPullZoneName;
    return data;
  }
}

class Links {
  String ?url;
  String ?label;
  bool ?active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
