import '../../database_helper/menstrual_cycle_db_helper.dart';

class UserSymptomsLogs {
  String? meditationTime;
  String? sleepTime;
  String? waterValue;
  String? bodyTemperatureUnit;
  String? waterUnit;
  String? weightUnit;
  String? notes;
  String? weight;
  String? bodyTemperature;
  String? logDate;
  List<SymptomsData>? symptomData = <SymptomsData>[];

  UserSymptomsLogs(
      {this.meditationTime,
      this.sleepTime,
      this.waterValue,
      this.bodyTemperatureUnit,
      this.waterUnit,
      this.weightUnit,
      this.notes,
      this.weight,
      this.bodyTemperature,
      this.logDate,
      this.symptomData});

  UserSymptomsLogs.fromJson(Map<String, dynamic> json) {
    meditationTime = json['meditationTime'];
    sleepTime = json['sleepTime'];
    waterValue = json['waterValue'];
    bodyTemperatureUnit = json['bodyTemperatureUnit'];
    waterUnit = json['waterUnit'];
    weightUnit = json['weightUnit'];
    notes = json['notes'];
    weight = json['weight'];
    logDate = json['logDate'];
    bodyTemperature = json['bodyTemperature'];
    if (json['symptomData'] != null) {
      symptomData = <SymptomsData>[];
      json['symptomData'].forEach((v) {
        symptomData!.add(SymptomsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meditationTime'] = meditationTime;
    data['sleepTime'] = sleepTime;
    data['waterValue'] = waterValue;
    data['bodyTemperatureUnit'] = bodyTemperatureUnit;
    data['waterUnit'] = waterUnit;
    data['weightUnit'] = weightUnit;
    data['notes'] = notes;
    data['weight'] = weight;
    data['logDate'] = logDate;
    data['bodyTemperature'] = bodyTemperature;
    if (symptomData != null) {
      data['symptomData'] = symptomData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
