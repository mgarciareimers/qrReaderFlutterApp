class ScanModel {
  int id;
  String type;
  String value;

  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    if (this.value.contains('http')) {
      this.type = 'http';
    } else if (this.value.contains('geo')){
      this.type = 'geo';
    } else {
      this.type = '';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
    id: json['id'],
    type: json['type'],
    value: json['value'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'value': value,
  };
}