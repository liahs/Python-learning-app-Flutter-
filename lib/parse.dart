import 'dart:convert';
import "package:flutter/services.dart" show rootBundle;
import'dart:async' show Future;

class Data{
  final List intro;
  final List variables;
  final List numbers;
  final List strings;
  final List conditional;
  final List functions;
  final List list;
  final List dictionaries;
  final List sets;
  final List oops;

  Data({this.intro,this.variables,this.numbers,this.strings,this.conditional,this.functions,this.list,this.dictionaries,this.sets,this.oops});

  factory Data.fromJson(Map<String,dynamic> json){
    return Data(
      intro:json["Intro"],
      variables: json['Variables'],
      numbers: json['Numbers'],
      strings: json['String'],
      conditional: json['Conditional'],
      functions: json['Functions'],
      list: json['Lists'],
      dictionaries: json['Dictionaries'],
      sets: json['Sets'],
      oops: json['OOPs']
    );
  }

}

Future<String> _loadDataAsset() async {
  return await rootBundle.loadString('assets/data.json');
}
Future<Data> loadData() async {
  String jsonAddress = await _loadDataAsset();

  final jsonResponse = json.decode(jsonAddress);
  Data data = new Data.fromJson(jsonResponse);
  return data;
}