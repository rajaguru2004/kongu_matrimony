class InterestModel {
  final int id;
  final String interestId;
  final String senderRegisterId;
  final String receiverRegisterId;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String? profilePhotoUrl;
  final String age;
  final String height;
  final String placeOfBirth;

  InterestModel({
    required this.id,
    required this.interestId,
    required this.senderRegisterId,
    required this.receiverRegisterId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.profilePhotoUrl,
    required this.age,
    required this.height,
    required this.placeOfBirth,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'] as int? ?? 0,
      interestId: json['interestId']?.toString() ?? '',
      senderRegisterId: json['senderRegisterId']?.toString() ?? '',
      receiverRegisterId: json['receiverRegisterId']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      profilePhotoUrl: json['profilePhotoUrl']?.toString(),
      age: json['age']?.toString() ?? '',
      height: json['height']?.toString() ?? '',
      placeOfBirth: json['placeOfBirth']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'interestId': interestId,
      'senderRegisterId': senderRegisterId,
      'receiverRegisterId': receiverRegisterId,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'name': name,
      'profilePhotoUrl': profilePhotoUrl,
      'age': age,
      'height': height,
      'placeOfBirth': placeOfBirth,
    };
  }
}

class InterestsResponseModel {
  final bool success;
  final String message;
  final List<InterestModel> data;

  InterestsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory InterestsResponseModel.fromJson(Map<String, dynamic> json) {
    return InterestsResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message']?.toString() ?? '',
      data:
          (json['data'] as List?)
              ?.map(
                (item) => InterestModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
