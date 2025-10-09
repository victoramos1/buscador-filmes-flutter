import 'package:flutter/material.dart';
import 'paginaInicial.dart';
import 'detalhes.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Buscador de filmes",
    home: PaginaInicial(),
  ));
}