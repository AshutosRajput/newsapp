import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:newsapp/details.dart';



class HeadlinesScreen extends StatefulWidget {
  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  fetchArticle()async{
    var url;
    url=await
    http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2022-11-16&sortBy=publishedAt&apiKey=7d16ef8d71b44a9d91b233c0aadad041'));
    return jsonDecode(url.body)['articles'];
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text(
            "HEADLINES",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: fetchArticle(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12),

                        child: InkWell(
                          onTap: (){
                         
                          }
                       ,
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data[index]["urlToImage"]
                                          .toString()),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data[index]["title"].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 20, 40, 10),
                                  child: Row(
                                    children: [
                                      Text(
                                          snapshot.data[index]["author"].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(snapshot.data[index]["publishedAt"]
                                          .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    );

                  }
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}