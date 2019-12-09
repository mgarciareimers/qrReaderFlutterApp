class Scan {
  int id;
  String type;
  String value;

  Scan({
    this.id,
    this.type,
    this.value,
  });

  factory Scan.fromJson(Map<String, dynamic> json) => Scan(
    id: json["id"],
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "value": value,
  };
}