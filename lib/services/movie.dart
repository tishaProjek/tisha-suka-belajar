import 'package:flutter/widgets.dart';
import 'package:tokob_online/models/movie.dart';
import 'package:tokob_online/models/response_data_list.dart';
import 'package:tokob_online/models/response_data_map.dart';
import 'package:tokob_online/models/user_login.dart';
import 'package:tokob_online/services/url.dart' as url;
import 'package:http/http.dart' as http;
import 'package:tokob_online/views/movie_view.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class MovieService {
  Future getMovie() async {
   UserLogin userLogin = UserLogin();
var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'Anda belum login / Token invalid',
      );
    }

    var uri = Uri.parse(url.BaseUrl + "/admin/getmovie");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
    };

    var getMovie = await http.get(uri, headers: headers);

    if (getMovie.statusCode == 200) {
      var data = json.decode(getMovie.body);
      if (data["status"] == true) {
        List<MovieModel> movie = data["data"].map<MovieModel>((r) => MovieModel.fromJson(r)).toList();
        return ResponseDataList(status: true, message: 'Success load data', data: movie);
      } else {
        return ResponseDataList(status: false, message: 'Failed load data');
      }
    } else {
      return ResponseDataList(
        status: false,
        message: "Gagal load movie dengan kode error ${getMovie.statusCode}",
      );
    }
  }

  Future insertMovie(Map<String, dynamic> request, var image, String? id) async {
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
      response = http.MultipartRequest('POST', Uri.parse("${url.BaseUrl}/admin/insertmovie"));
    } else {
      response = http.MultipartRequest('POST', Uri.parse("${url.BaseUrl}/admin/updatemovie/$id"));
    }

    if (image != null) {
      response.files.add(await http.MultipartFile.fromPath('posterpath', image.path));
    }

    response.headers.addAll(headers);
    response.fields['title'] = request["title"];
    response.fields['voteaverage'] = request["voteaverage"];
    response.fields['overview'] = request["overview"];

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

  Future hapusMovie(String id) async {
    UserLogin userLogin = UserLogin();
var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(status: false, message: 'Anda belum login / Token invalid');
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
        message: "Gagal hapus movie dengan kode error ${hapusMovie.statusCode}",
      );
    }
  }
}
