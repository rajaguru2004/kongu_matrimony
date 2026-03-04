class UserModel {
  final int id;
  final String registerId;
  final String profileFor;
  final String name;
  final String phone;
  final String gender;
  final String dob;
  final String timeOfBirth;
  final String placeOfBirth;
  final String email;
  final String alternatePhone;
  final String address;
  final String? city;
  final String pincode;
  final String state;
  final String country;
  final String identityProofFront;
  final String identityProofBack;
  final String parentIdentityFront;
  final String parentIdentityBack;
  final String yourCaste;
  final String yourKootam;
  final String yourDosham;
  final String yourStar;
  final String yourRasi;
  final String yourHoroscopeType;
  final String yourHoroscopeFileUrl;
  final String? bioDataUrl;
  final String maritalStatus;
  final String height;
  final String familyStatus;
  final String familyType;
  final String familyValues;
  final String anyDisability;
  final String age;
  final String highestEducation;
  final String additionalDegree;
  final String employedIn;
  final String occupation;
  final String otherOccupation;
  final String annualIncome;
  final String? profession;
  final String workLocation;
  final String additionalIncome;
  final String familyNetWorth;
  final String motherOccupation;
  final String fatherOccupation;
  final String? fatherName;
  final String? motherName;
  final String aboutWork;
  final int? siblingsCount;
  final String? siblingsDescription;
  final String? education;
  final int partnerMinAge;
  final int partnerMaxAge;
  final String partnerMaritalStatus;
  final String partnerEducation;
  final String partnerProfession;
  final String partnerJobLocation;
  final String partnerAnnualInacome;
  final String partnerCaste;
  final String partnerKulam;
  final String? partnerHoroscopeType;
  final String partnerStar;
  final String partnerRasi;
  final String partnerDosham;
  final String? partnerKootam;
  final String aboutYou;
  final String? partnerExpectation;
  final String profilePhotoUrl;
  final bool isCompleted;
  final int creditAmount;
  final String permissionId;
  final bool isPlanActive;
  final String planType;
  final String? planStartDate;
  final String? planEndDate;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? interestStatus;

  UserModel({
    required this.id,
    required this.registerId,
    required this.profileFor,
    required this.name,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.email,
    required this.alternatePhone,
    required this.address,
    this.city,
    required this.pincode,
    required this.state,
    required this.country,
    required this.identityProofFront,
    required this.identityProofBack,
    required this.parentIdentityFront,
    required this.parentIdentityBack,
    required this.yourCaste,
    required this.yourKootam,
    required this.yourDosham,
    required this.yourStar,
    required this.yourRasi,
    required this.yourHoroscopeType,
    required this.yourHoroscopeFileUrl,
    this.bioDataUrl,
    required this.maritalStatus,
    required this.height,
    required this.familyStatus,
    required this.familyType,
    required this.familyValues,
    required this.anyDisability,
    required this.age,
    required this.highestEducation,
    required this.additionalDegree,
    required this.employedIn,
    required this.occupation,
    required this.otherOccupation,
    required this.annualIncome,
    this.profession,
    required this.workLocation,
    required this.additionalIncome,
    required this.familyNetWorth,
    required this.motherOccupation,
    required this.fatherOccupation,
    this.fatherName,
    this.motherName,
    required this.aboutWork,
    this.siblingsCount,
    this.siblingsDescription,
    this.education,
    required this.partnerMinAge,
    required this.partnerMaxAge,
    required this.partnerMaritalStatus,
    required this.partnerEducation,
    required this.partnerProfession,
    required this.partnerJobLocation,
    required this.partnerAnnualInacome,
    required this.partnerCaste,
    required this.partnerKulam,
    this.partnerHoroscopeType,
    required this.partnerStar,
    required this.partnerRasi,
    required this.partnerDosham,
    this.partnerKootam,
    required this.aboutYou,
    this.partnerExpectation,
    required this.profilePhotoUrl,
    required this.isCompleted,
    required this.creditAmount,
    required this.permissionId,
    required this.isPlanActive,
    required this.planType,
    this.planStartDate,
    this.planEndDate,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.interestStatus,
  });

  UserModel copyWith({
    int? id,
    String? registerId,
    String? profileFor,
    String? name,
    String? phone,
    String? gender,
    String? dob,
    String? timeOfBirth,
    String? placeOfBirth,
    String? email,
    String? alternatePhone,
    String? address,
    String? city,
    String? pincode,
    String? state,
    String? country,
    String? identityProofFront,
    String? identityProofBack,
    String? parentIdentityFront,
    String? parentIdentityBack,
    String? yourCaste,
    String? yourKootam,
    String? yourDosham,
    String? yourStar,
    String? yourRasi,
    String? yourHoroscopeType,
    String? yourHoroscopeFileUrl,
    String? bioDataUrl,
    String? maritalStatus,
    String? height,
    String? familyStatus,
    String? familyType,
    String? familyValues,
    String? anyDisability,
    String? age,
    String? highestEducation,
    String? additionalDegree,
    String? employedIn,
    String? occupation,
    String? otherOccupation,
    String? annualIncome,
    String? profession,
    String? workLocation,
    String? additionalIncome,
    String? familyNetWorth,
    String? motherOccupation,
    String? fatherOccupation,
    String? fatherName,
    String? motherName,
    String? aboutWork,
    int? siblingsCount,
    String? siblingsDescription,
    String? education,
    int? partnerMinAge,
    int? partnerMaxAge,
    String? partnerMaritalStatus,
    String? partnerEducation,
    String? partnerProfession,
    String? partnerJobLocation,
    String? partnerAnnualInacome,
    String? partnerCaste,
    String? partnerKulam,
    String? partnerHoroscopeType,
    String? partnerStar,
    String? partnerRasi,
    String? partnerDosham,
    String? partnerKootam,
    String? aboutYou,
    String? partnerExpectation,
    String? profilePhotoUrl,
    bool? isCompleted,
    int? creditAmount,
    String? permissionId,
    bool? isPlanActive,
    String? planType,
    String? planStartDate,
    String? planEndDate,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? interestStatus,
  }) {
    return UserModel(
      id: id ?? this.id,
      registerId: registerId ?? this.registerId,
      profileFor: profileFor ?? this.profileFor,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      timeOfBirth: timeOfBirth ?? this.timeOfBirth,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      email: email ?? this.email,
      alternatePhone: alternatePhone ?? this.alternatePhone,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      country: country ?? this.country,
      identityProofFront: identityProofFront ?? this.identityProofFront,
      identityProofBack: identityProofBack ?? this.identityProofBack,
      parentIdentityFront: parentIdentityFront ?? this.parentIdentityFront,
      parentIdentityBack: parentIdentityBack ?? this.parentIdentityBack,
      yourCaste: yourCaste ?? this.yourCaste,
      yourKootam: yourKootam ?? this.yourKootam,
      yourDosham: yourDosham ?? this.yourDosham,
      yourStar: yourStar ?? this.yourStar,
      yourRasi: yourRasi ?? this.yourRasi,
      yourHoroscopeType: yourHoroscopeType ?? this.yourHoroscopeType,
      yourHoroscopeFileUrl: yourHoroscopeFileUrl ?? this.yourHoroscopeFileUrl,
      bioDataUrl: bioDataUrl ?? this.bioDataUrl,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      height: height ?? this.height,
      familyStatus: familyStatus ?? this.familyStatus,
      familyType: familyType ?? this.familyType,
      familyValues: familyValues ?? this.familyValues,
      anyDisability: anyDisability ?? this.anyDisability,
      age: age ?? this.age,
      highestEducation: highestEducation ?? this.highestEducation,
      additionalDegree: additionalDegree ?? this.additionalDegree,
      employedIn: employedIn ?? this.employedIn,
      occupation: occupation ?? this.occupation,
      otherOccupation: otherOccupation ?? this.otherOccupation,
      annualIncome: annualIncome ?? this.annualIncome,
      profession: profession ?? this.profession,
      workLocation: workLocation ?? this.workLocation,
      additionalIncome: additionalIncome ?? this.additionalIncome,
      familyNetWorth: familyNetWorth ?? this.familyNetWorth,
      motherOccupation: motherOccupation ?? this.motherOccupation,
      fatherOccupation: fatherOccupation ?? this.fatherOccupation,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      aboutWork: aboutWork ?? this.aboutWork,
      siblingsCount: siblingsCount ?? this.siblingsCount,
      siblingsDescription: siblingsDescription ?? this.siblingsDescription,
      education: education ?? this.education,
      partnerMinAge: partnerMinAge ?? this.partnerMinAge,
      partnerMaxAge: partnerMaxAge ?? this.partnerMaxAge,
      partnerMaritalStatus: partnerMaritalStatus ?? this.partnerMaritalStatus,
      partnerEducation: partnerEducation ?? this.partnerEducation,
      partnerProfession: partnerProfession ?? this.partnerProfession,
      partnerJobLocation: partnerJobLocation ?? this.partnerJobLocation,
      partnerAnnualInacome: partnerAnnualInacome ?? this.partnerAnnualInacome,
      partnerCaste: partnerCaste ?? this.partnerCaste,
      partnerKulam: partnerKulam ?? this.partnerKulam,
      partnerHoroscopeType: partnerHoroscopeType ?? this.partnerHoroscopeType,
      partnerStar: partnerStar ?? this.partnerStar,
      partnerRasi: partnerRasi ?? this.partnerRasi,
      partnerDosham: partnerDosham ?? this.partnerDosham,
      partnerKootam: partnerKootam ?? this.partnerKootam,
      aboutYou: aboutYou ?? this.aboutYou,
      partnerExpectation: partnerExpectation ?? this.partnerExpectation,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      creditAmount: creditAmount ?? this.creditAmount,
      permissionId: permissionId ?? this.permissionId,
      isPlanActive: isPlanActive ?? this.isPlanActive,
      planType: planType ?? this.planType,
      planStartDate: planStartDate ?? this.planStartDate,
      planEndDate: planEndDate ?? this.planEndDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      interestStatus: interestStatus ?? this.interestStatus,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      registerId: json['registerId'] ?? '',
      profileFor: json['profileFor'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      timeOfBirth: json['timeOfBirth'] ?? '',
      placeOfBirth: json['placeOfBirth'] ?? '',
      email: json['email'] ?? '',
      alternatePhone: json['alternatePhone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'],
      pincode: json['pincode'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      identityProofFront: json['identityProofFront'] ?? '',
      identityProofBack: json['identityProofBack'] ?? '',
      parentIdentityFront: json['parentIdentityFront'] ?? '',
      parentIdentityBack: json['parentIdentityBack'] ?? '',
      yourCaste: json['yourCaste'] ?? '',
      yourKootam: json['yourKootam'] ?? '',
      yourDosham: json['yourDosham'] ?? '',
      yourStar: json['yourStar'] ?? '',
      yourRasi: json['yourRasi'] ?? '',
      yourHoroscopeType: json['yourHoroscopeType'] ?? '',
      yourHoroscopeFileUrl: json['yourHoroscopeFileUrl'] ?? '',
      bioDataUrl: json['bioDataUrl'],
      maritalStatus: json['maritalStatus'] ?? '',
      height: json['height'] ?? '',
      familyStatus: json['familyStatus'] ?? '',
      familyType: json['familyType'] ?? '',
      familyValues: json['familyValues'] ?? '',
      anyDisability: json['anyDisability'] ?? '',
      age: json['age'] ?? '',
      highestEducation: json['highestEducation'] ?? '',
      additionalDegree: json['additionalDegree'] ?? '',
      employedIn: json['employedIn'] ?? '',
      occupation: json['occupation'] ?? '',
      otherOccupation: json['otherOccupation'] ?? '',
      annualIncome: json['annualIncome'] ?? '',
      profession: json['profession'],
      workLocation: json['workLocation'] ?? '',
      additionalIncome: json['additionalIncome'] ?? '',
      familyNetWorth: json['familyNetWorth'] ?? '',
      motherOccupation: json['motherOccupation'] ?? '',
      fatherOccupation: json['fatherOccupation'] ?? '',
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      aboutWork: json['aboutWork'] ?? '',
      siblingsCount: json['siblingsCount'],
      siblingsDescription: json['siblingsDescription'],
      education: json['education'],
      partnerMinAge: json['partnerMinAge'] ?? 0,
      partnerMaxAge: json['partnerMaxAge'] ?? 0,
      partnerMaritalStatus: json['partnerMaritalStatus'] ?? '',
      partnerEducation: json['partnerEducation'] ?? '',
      partnerProfession: json['partnerProfession'] ?? '',
      partnerJobLocation: json['partnerJobLocation'] ?? '',
      partnerAnnualInacome: json['partnerAnnualInacome'] ?? '',
      partnerCaste: json['partnerCaste'] ?? '',
      partnerKulam: json['partnerKulam'] ?? '',
      partnerHoroscopeType: json['partnerHoroscopeType'],
      partnerStar: json['partnerStar'] ?? '',
      partnerRasi: json['partnerRasi'] ?? '',
      partnerDosham: json['partnerDosham'] ?? '',
      partnerKootam: json['partnerKootam'],
      aboutYou: json['aboutYou'] ?? '',
      partnerExpectation: json['partnerExpectation'],
      profilePhotoUrl: json['profilePhotoUrl'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      creditAmount: json['creditAmount'] ?? 0,
      permissionId: json['permissionId'] ?? '',
      isPlanActive: json['isPlanActive'] ?? false,
      planType: json['planType'] ?? '',
      planStartDate: json['planStartDate'],
      planEndDate: json['planEndDate'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      deletedAt: json['deletedAt'],
      interestStatus: json['interestStatus'],
    );
  }
}
