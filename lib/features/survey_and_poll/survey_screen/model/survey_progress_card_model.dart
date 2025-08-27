class PoolOption {
  final String option;
  final int totalResponse;
  final double responsePercentage;

  PoolOption({
    required this.option,
    required this.totalResponse,
    required this.responsePercentage,
  });

  factory PoolOption.fromJson(Map<String, dynamic> json) {
    return PoolOption(
      option: json['option'] ?? '',
      totalResponse: json['totalResponse'] ?? 0,
      responsePercentage: (json['responsePercentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'option': option,
      'totalResponse': totalResponse,
      'responsePercentage': responsePercentage,
    };
  }
}

class PoolResponseModel {
  final String id;
  final String title;
  final String description;
  final int totalResponse;
  final List<PoolOption> options;

  PoolResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.totalResponse,
    required this.options,
  });

  factory PoolResponseModel.fromJson(Map<String, dynamic> json) {
    return PoolResponseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      totalResponse: json['totalResponse'] ?? 0,
      options: (json['options'] as List<dynamic>?)
          ?.map((option) => PoolOption.fromJson(option))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'totalResponse': totalResponse,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}