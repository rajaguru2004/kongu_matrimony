class PlanModel {
  final int id;
  final String planId;
  final String name;
  final String description;
  final int price; // in rupees
  final int durationDays;
  final bool isActive;

  PlanModel({
    required this.id,
    required this.planId,
    required this.name,
    required this.description,
    required this.price,
    required this.durationDays,
    required this.isActive,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] as int,
      planId: json['planId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      durationDays: json['durationDays'] as int,
      isActive: json['isActive'] as bool,
    );
  }
}
