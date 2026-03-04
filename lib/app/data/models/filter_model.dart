class FilterModel {
  int? minAge;
  int? maxAge;
  String? annualIncome;
  String? familyIncome;
  String? education;
  String? job;
  String? dosham;
  String? maritalStatus;
  String? country;

  FilterModel({
    this.minAge,
    this.maxAge,
    this.annualIncome,
    this.familyIncome,
    this.education,
    this.job,
    this.dosham,
    this.maritalStatus,
    this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      if (minAge != null) 'minAge': minAge,
      if (maxAge != null) 'maxAge': maxAge,
      if (annualIncome != null && annualIncome != 'Any Income')
        'annualIncome': annualIncome!.toLowerCase().replaceAll(' ', '-'),
      if (familyIncome != null && familyIncome != 'Any Income')
        'familyIncome': familyIncome!.toLowerCase().replaceAll(' ', '-'),
      if (education != null && education != 'Any Education')
        'education': education!.toLowerCase().replaceAll(' ', '-'),
      if (job != null && job != 'Any Job')
        'occupation': job!.toLowerCase().replaceAll(' ', '-'),
      if (dosham != null && dosham != 'Any Dosham')
        'yourDosham': dosham!.toLowerCase().replaceAll(' ', '-'),
      if (maritalStatus != null && maritalStatus != 'Any Status')
        'maritalStatus': maritalStatus!.toLowerCase().replaceAll(' ', '-'),
      if (country != null && country != 'Select Countries')
        'workLocation': country,
    };
  }
}
