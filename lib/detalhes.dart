import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'resultadoBusca.dart';
import 'dart:convert';

class Detalhes extends StatefulWidget {

  final int id;
  const Detalhes(this.id,{super.key});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {

  Map<String, dynamic> filme = {};
  String apiKey = "";

  Future<Map<String, dynamic>> dadosRecebidos() async{
    var retorno = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${widget.id}?api_key=${apiKey}&language=pt-BR"));
    filme = jsonDecode(retorno.body);
    return filme;
  }

  void buscarFilme(){
    dadosRecebidos().then((dados){
      setState(() {
        filme = dados;
      });
  });
}

  @override
  void initState() {
    // TODO: implement initState
    buscarFilme();
  }

  TextEditingController controller = TextEditingController();

  void fazerBusca (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultadoBusca(controller.text)));
  }

  @override
  Widget build(BuildContext context) {
    if (filme.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Carregando..."),
          backgroundColor: Color(0xff14181c),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final urlImagem = filme["poster_path"];
    final titulo = filme["title"];
    final nota = filme["vote_average"];
    final descricao = filme["overview"];
    final orcamento = filme["budget"];
    final bilheteria = filme["revenue"];

    Widget imagemFilme() {
      if (urlImagem != null && urlImagem.isNotEmpty && urlImagem != "null") {
        return Image.network("https://image.tmdb.org/t/p/w500/$urlImagem",
          height: 500,
          width: double.infinity,
          fit: BoxFit.cover
        );
      } else {
        return Image.asset(
          "imagens/sem-imagem.jpg",
          height: 500,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset("imagens/icone.png"),
        ),
        title: Text(
          "Buscador de filmes",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Color(0xff14181c),
        actions: [
          Container(
            width: 100,
            height: 45,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Digite",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(25, 45),
              backgroundColor: Color(0xff00c030),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            onPressed: fazerBusca,
            child: Text(
              "Buscar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
        color: Color(0xff14181c),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16),
                        backgroundColor: Color(0xff00c030),
                        foregroundColor: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff14181c),
                        ),
                        width: 300,
                        height: 500,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(17),
                            bottom: Radius.circular(17),
                          ),
                          child: imagemFilme(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          titulo,
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Nota TMDB: ${nota.toStringAsFixed(1)}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Bilheteria: U\$ ${bilheteria.toString()}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Custo: U\$ ${orcamento.toString()}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                        child: Text(
                          "Sinopse: $descricao",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}