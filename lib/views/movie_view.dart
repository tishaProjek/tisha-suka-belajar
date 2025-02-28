import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tokob_online/models/movie.dart';
import 'package:tokob_online/services/movie.dart';
import 'package:tokob_online/widgets/alert.dart';

class _MovieViewState extends State<MovieView> {
  MovieService movie = MovieService();
  List action =["Update", "Hapus"];
  List? film;
  getfilm() async {
    ResponseDataList getMovie = await movie.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) =>
              tambahMovieView(title: "Tambah Movie", item : {})));
          }, 
          icon: Icon (Icons.add)),
        ],
        ),
        body: film != null
        ? ListView.builder(
          itemCount: film!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(film! [index].title),
                trailing: 
                PopupMenuButton(itemBuilder: (BuildContext content) {
                  return action.map((r) {
                    return PopupMenuItem(
                      onTap: () async {
                        if (r == "Update") {
                          Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => tambahMovieView(
                                            title: "Update Movie",
                                            item: film![index])));
                        } else {
                          var results = await AlertMessage()
                          .showAlertDialog(context);
                          if (results != null &&
                              results.containsKey('status')) {
                            if (results['status'] == true) {
                              var res = await movie.hapusMovie(
                                context, film![index].id);
                                if (res.status == true) {
                                  AlertMessage().showAlert(
                                    context, res.message, true);
                                  getfilm();  
                                } else {
                                  AlertMessage().showAlert(
                                    context, res.message, false);
                              }
                            }
                          }
                        }
                      },
                      value: r,
                      child:Text(r), //wajib ada ketika ada action.map
                    );
                  }).toList(); //perlu ini jika ada map.()
                }),
                leading: Image(image: NetworkImage(film![index].posterPath)),
              ),
            );
          })
       : Center(
          child: CircularProgressIndicator(),
       ),
      bottomNavigationBar: BottomNav(1),
    ); 
  }
  tambahMovieView({required String title, required Map item}) {}
}