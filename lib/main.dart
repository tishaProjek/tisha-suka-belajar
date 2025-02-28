import 'package:flutter/material.dart';
import 'package:tokob_online/views/dasboard.dart';
import 'package:tokob_online/views/login_view.dart';
import 'package:tokob_online/views/movie_view.dart';
import 'package:tokob_online/views/pesan_view.dart';
import 'package:tokob_online/views/register_user_view.dart';
import 'dart:io';



void main() {
  runApp(MaterialApp(
    initialRoute:'/login',
    routes: {
      '/':( context)=> RegisterUserView(),
      '/login':(context) => LoginView(),
      '/dashboard' : (context) => DashboardView(),
      '/movie':(context) => const MovieView(),
      '/pesan': (context)=> PesanView(),
    }
  ));
}

