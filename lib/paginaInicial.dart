import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset("imagens/icone.png"),
        ),
        title: Text("Buscador de filmes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
        backgroundColor: Color(0xff14181c),  
        actions: [
          Container(
            width: 100,
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Digite",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                  )
                )
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
                  bottomRight: Radius.circular(10)
                )
              )
            ),
            onPressed: (){},
            child: Text("Buscar",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Color(0xff14181c),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff14181c)
                  ),
                  width: 300,
                  height: 500,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(17),
                        ),
                        child: Image.asset(
                          "imagens/sem-imagem.jpg",
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Teste 1: A Missão",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
