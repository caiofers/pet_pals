import 'dart:convert';
import 'package:pet_pals/data/models/pet_data_model.dart';

class PetsMockService {
  var json = '''
    {
    "pets": [
      {
        "id": "==abc",
        "name": "Cacau",
        "type": 0,
        "breed": "Vira lata",
        "birthdate": "2020-12-13T07:51:26 -03:00",
        "imgUrl": "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8xNV9waG90b19vZl9hX2RvZ19ydW5uaW5nX3dpdGhfb3duZXJfYXRfcGFya19lcF9mM2I3MDQyZC0zNWJlLTRlMTQtOGZhNy1kY2Q2OWQ1YzQzZjlfMi5qcGc.jpg",
        "gender": 0,
        "tutorIds": [
          "user123", 
          "user124"
        ],
        "alarmIds": [
          "alarm123",
          "alarm124"
        ]
      },
      {
        "id": "==abca",
        "name": "Snoopy",
        "type": 0,
        "breed": "Vira lata",
        "birthdate": "2020-12-13T07:51:26 -03:00",
        "imgUrl": "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8xNV9waG90b19vZl9hX2RvZ19ydW5uaW5nX3dpdGhfb3duZXJfYXRfcGFya19lcF9mM2I3MDQyZC0zNWJlLTRlMTQtOGZhNy1kY2Q2OWQ1YzQzZjlfMi5qcGc.jpg",
        "gender": 0,
        "tutorIds": [
          "user123", 
          "user124"
        ],
        "alarmIds": [
          "alarm123",
          "alarm124"
        ]
      }
    ]
  }
  ''';

  List<PetDataModel> getPets() {
    var petsJson = jsonDecode(json)['pets'] as List;
    List<PetDataModel> pets = petsJson
        .map(
          (pet) => PetDataModel.fromJson(pet),
        )
        .toList();
    return pets;
  }
}
