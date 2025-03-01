import 'dart:convert';
import 'package:tokob_online/models/response_data_map.dart';
import 'package:tokob_online/models/user_login.dart';
import 'package:tokob_online/services/url.dart' as url;
import 'package:http/http.dart' as http;

class UserService {
  Future registerUser(data) async {
    var uri = Uri.parse(url.BaseUrl + "/register_admin");
    var register = await http.post(uri, body: data);

    if (register.statusCode == 200) {
      var data = json.decode(register.body);
      if (data["status"] == true) {
        ResponseDataMap response = ResponseDataMap(
            status: true, message: "Sukses menambah user", data: data);
        return response;
      } else {
        var message = '';
        for (String key in data["message"].keys) {
          message += data["message"][key][0].toString() + '\n';
        }
        ResponseDataMap response =
            ResponseDataMap(status: false, message: message);
        return response;
      }
    } else {
      ResponseDataMap response = ResponseDataMap(
          status: false,
          message: "MaaFP gagal menambah user dan Kode ${register.statusCode}");
      return response;
    }
  }

  Future loginUser(datas) async {
    var uri = Uri.parse(url.BaseUrl + "/auth/login");
    var register = await http.post(uri, body: datas);
    var data = json.decode(register.body);

    if (register.statusCode == 200) {
      if (data.containsKey("status") && data["status"] == true) {
        UserLogin userLogin = UserLogin(
            status: data["status"],
            token: data["authorization"]["token"],
            message: data["message"],
            id: data["data"]["id"], // Data user ada di "data"
            nama_user: data["data"]["name"], // Sesuai field API
            email: data["data"]["email"],
            role: data["data"]["role"]);
        await userLogin.prefs();
        ResponseDataMap response = ResponseDataMap(
            status: true, message: "AseLole Sukses", data: data);
        return response;
      } else {
        ResponseDataMap response =
            ResponseDataMap(status: false, message: 'Email dan password salah');
        return response;
      }
    } else {
      ResponseDataMap response = ResponseDataMap(
          status: false,
          message:
              "gagal menambah user dengan code error ${register.statusCode}");
      return response;
    }
  }
}
