
import 'package:tokob_online/models/barang_model.dart';
import 'package:tokob_online/models/response_data_list.dart';
import 'package:tokob_online/models/response_data_map.dart';
import 'package:tokob_online/models/user_login.dart';
import 'package:tokob_online/services/url.dart' as url;
import 'package:http/http.dart' as http;
import 'dart:convert';



class BarangService {
  Future getBarang() async {
   UserLogin userLogin = UserLogin();
var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'Anda belum login / Token invalid',
      );
    }

    var uri = Uri.parse(url.BaseUrl + "/admin/getBarang");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
    };

    var getBarang = await http.get(uri, headers: headers);

    if (getBarang.statusCode == 200) {
      var data = json.decode(getBarang.body);
      if (data["status"] == true) {
        List<BarangModel> movie = data["data"].map<BarangModel>((r) => BarangModel.fromJson(r)).toList();
        return ResponseDataList(status: true, message: 'ASeLole berhasil', data: movie);
      } else {
        return ResponseDataList(status: false, message: 'yah gagGal Niih..');
      }
    } else {
      return ResponseDataList(
        status: false,
        message: "Gagal load movie dengan kode error ${getBarang.statusCode}",
      );
    }
  }

Future insertBarang(Map<String, dynamic> request, var image, {String? id}) async {
    UserLogin userLogin = UserLogin();
var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(status: false, message: 'Anda belum login / Token invalid');
    }

    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
      "Content-type": "multipart/form-data",
    };

    var response;
    if (id == null) {
      response = http.MultipartRequest('POST', Uri.parse("${url.BaseUrl}/admin/insertbarang"));
    } else {
      response = http.MultipartRequest('POST', Uri.parse("${url.BaseUrl}/admin/updatebarang/$id"));
    }

    if (image != null) {
      response.files.add(await http.MultipartFile.fromPath('posterpath', image.path));
    }
    response.headers.addAll(headers);
    response.fields['name'] = request["nama"];
    response.fields['price'] = request["harga"];
    response.fields['description'] = request["deskripsi"];

    var res = await response.send();
    var result = await http.Response.fromStream(res);

    if (res.statusCode == 200) {
      var data = json.decode(result.body);
      return ResponseDataMap(
        status: data["status"],
        message: data["status"] ? 'Success insert / update data' : 'Failed insert / update data',
      );
    } else {
      return ResponseDataMap(
        status: false,
        message: "Gagal insert/update movie dengan kode error ${res.statusCode}",
      );
    }
  }

  Future hapusBarang(String id) async {
    UserLogin userLogin = UserLogin();
var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(status: false, message: 'kAmu belum login / Token invalid');
    }

    var uri = Uri.parse(url.BaseUrl + "/admin/hapusmovie/$id");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
    };

    var hapusMovie = await http.delete(uri, headers: headers);

    if (hapusMovie.statusCode == 200) {
      var result = json.decode(hapusMovie.body);
      return ResponseDataList(
        status: result["status"],
        message: result["status"] ? 'Success hapus data' : 'Failed hapus data',
      );
    } else {
      return ResponseDataList(
        status: false,
        message: "yahH gAGAl hapus BaraNG  dengan kode error ${hapusMovie.statusCode}",
      );
    }
  }
}
