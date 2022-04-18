class CouponDetails {
  CouponDetails({
    this.id,
    this.couponCode,
    this.description,
    this.discountType,
    this.couponAmount,
    this.couponExpiryDate,
    this.usageCount,
    this.minimumAmount,
    this.maximumAmount,
    this.customerEmail,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.usageLimit,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? couponCode;
  final dynamic description;
  final String? discountType;
  final int? couponAmount;
  final dynamic couponExpiryDate;
  final int? usageCount;
  final int? minimumAmount;
  final int? maximumAmount;
  final dynamic customerEmail;
  final int? usageLimitPerUser;
  final dynamic limitUsageToXItems;
  final dynamic usageLimit;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CouponDetails.fromJson(Map<String, dynamic> json) => CouponDetails(
    id: json["id"],
    couponCode: json["coupon_code"],
    description: json["description"],
    discountType: json["discount_type"],
    couponAmount: json["coupon_amount"],
    couponExpiryDate: json["coupon_expiry_date"] == null ? null : DateTime.parse(json["coupon_expiry_date"]),
    usageCount: json["usage_count"],
    minimumAmount: json["minimum_amount"],
    maximumAmount: json["maximum_amount"],
    customerEmail: json["customer_email"],
    usageLimitPerUser: json["usage_limit_per_user"],
    limitUsageToXItems: json["limit_usage_to_x_items"],
    usageLimit: json["usage_limit"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coupon_code": couponCode,
    "description": description,
    "discount_type": discountType,
    "coupon_amount": couponAmount,
    "coupon_expiry_date": couponExpiryDate == null ? null : "${couponExpiryDate.year.toString().padLeft(4, '0')}-${couponExpiryDate.month.toString().padLeft(2, '0')}-${couponExpiryDate.day.toString().padLeft(2, '0')}",
    "usage_count": usageCount,
    "minimum_amount": minimumAmount,
    "maximum_amount": maximumAmount,
    "customer_email": customerEmail,
    "usage_limit_per_user": usageLimitPerUser,
    "limit_usage_to_x_items": limitUsageToXItems,
    "usage_limit": usageLimit,
    "deleted_at": deletedAt,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
  };
}