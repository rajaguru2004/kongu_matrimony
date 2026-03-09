class FilterModel {
  int? minAge;
  int? maxAge;
  String? annualIncome;
  String? familyNetWorth;
  String? education;
  String? highestEducation;
  String? occupation;
  String? dosham;
  String? caste;
  String? workCountry;
  String? maritalStatus;

  FilterModel({
    this.minAge,
    this.maxAge,
    this.annualIncome,
    this.familyNetWorth,
    this.education,
    this.highestEducation,
    this.occupation,
    this.dosham,
    this.caste,
    this.workCountry,
    this.maritalStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      if (minAge != null) 'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
      if (annualIncome != null && annualIncome != 'Any')
        'annualIncome': annualIncome,
      if (familyNetWorth != null && familyNetWorth != 'Any')
        'familyNetWorth': familyNetWorth,
      if (education != null && education != 'Any') 'education': education,
      if (highestEducation != null && highestEducation != 'Any')
        'highestEducation': highestEducation,
      if (occupation != null && occupation != 'Any') 'occupation': occupation,
      if (dosham != null && dosham != 'Any') 'dosham': dosham,
      if (caste != null && caste != 'Any') 'caste': caste,
      if (workCountry != null && workCountry != 'Any')
        'workCountry': workCountry,
      if (maritalStatus != null && maritalStatus != 'Any')
        'maritalStatus': maritalStatus,
    };
  }
}
