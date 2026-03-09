class SetupDataModel {
  final bool success;
  final List<SetupItem> data;

  SetupDataModel({required this.success, required this.data});

  factory SetupDataModel.fromJson(Map<String, dynamic> json) {
    return SetupDataModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List?)?.map((e) => SetupItem.fromJson(e)).toList() ??
          [],
    );
  }
}

class SetupItem {
  final int id;
  final String name;
  final bool isActive;

  SetupItem({required this.id, required this.name, required this.isActive});

  factory SetupItem.fromJson(Map<String, dynamic> json) {
    return SetupItem(
      id: json['id'],
      name: json['name'],
      isActive: json['isActive'] ?? true,
    );
  }
}
