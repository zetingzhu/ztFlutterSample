class CastsDTO {
  String? date;
  String? week;
  String? dayweather;
  String? nightweather;
  String? daytemp;
  String? nighttemp;
  String? daywind;
  String? nightwind;
  String? daypower;
  String? nightpower;
  String? daytempFloat;
  String? nighttempFloat;

  CastsDTO({
    this.date,
    this.week,
    this.dayweather,
    this.nightweather,
    this.daytemp,
    this.nighttemp,
    this.daywind,
    this.nightwind,
    this.daypower,
    this.nightpower,
    this.daytempFloat,
    this.nighttempFloat,
  });

  factory CastsDTO.fromJson(Map<String, dynamic> json) {
    return CastsDTO(
      date: json['date'],
      week: json['week'],
      dayweather: json['dayweather'],
      nightweather: json['nightweather'],
      daytemp: json['daytemp'],
      nighttemp: json['nighttemp'],
      daywind: json['daywind'],
      nightwind: json['nightwind'],
      daypower: json['daypower'],
      nightpower: json['nightpower'],
      daytempFloat: json['daytemp_float'],
      nighttempFloat: json['nighttemp_float'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['week'] = week;
    data['dayweather'] = dayweather;
    data['nightweather'] = nightweather;
    data['daytemp'] = daytemp;
    data['nighttemp'] = nighttemp;
    data['daywind'] = daywind;
    data['nightwind'] = nightwind;
    data['daypower'] = daypower;
    data['nightpower'] = nightpower;
    data['daytemp_float'] = daytempFloat;
    data['nighttemp_float'] = nighttempFloat;
    return data;
  }

  @override
  String toString() {
    return 'CastsDTO{date: $date, dayweather: $dayweather, nightweather: $nightweather}';
  }
}
