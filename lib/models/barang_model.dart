import 'package:tokob_online/services/url.dart' as url;

class BarangModel {
  int? id;
  String? name;
  double? price;
  String? description;
  String? image;
  BarangModel({
    required this.id,
    required this.name,
    this.price,
    this.description,
    required this.image,
  });
  BarangModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    name = parsedJson["nama barang"];
    price = double.parse(parsedJson["Harga"].toString());
    description = parsedJson["deskripsi"];
  }
}