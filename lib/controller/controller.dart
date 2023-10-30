import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../components/globaldata.dart';

class Controller with ChangeNotifier {
  FlutterTts flutterTts = FlutterTts();
  bool quelistReady = false;
  int timer = 7;
  bool status = false;
  List<bool> selectedTile = [];
  double pitch = 1.0;
  double speechrate = 0.4;
  List<String> languages = [];

  List<Map<String, dynamic>> queuetList = [];
  List<Map<String, dynamic>> queuetList1 = [];

  List<Map<String, dynamic>> settings = [];
  int? tileCount;
  int? showToken;
  String? branchColor;
  // double volume = 1.0;
  double? adv_vol = .0;

  double fontsize = 0.0;
  bool isLoading = true;
  bool isListLoading = true;

  getSettings(BuildContext context) async {
    try {
      Uri url = Uri.parse("http://$ip/API/initialize2.php");
      isLoading = true;
      notifyListeners();
      Map body = {'branch_id': br};
      print("body--$url--$body");
      http.Response response = await http.post(url,body: body);
      var map = jsonDecode(response.body);
      print("init map-----$map");
      settings.clear();
      for (var item in map) {
        settings.add(item);
      }
      tileCount = int.parse(settings[0]["token_row"]);
      showToken = int.parse(settings[0]["show_token"]);
      fontsize = double.parse(settings[0]["font_size"]);
      speechrate = double.parse(settings[0]["speech_rate"]);
      adv_vol = double.parse(settings[0]["adv_volume"]);
      notifyListeners();
      print("fontxisee-----$adv_vol");
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // branch_id = prefs.getString("branch_id");
      prefs.setString("token_row", tileCount.toString());
      isLoading = false;
      print("isloadun-----$isLoading");
      notifyListeners();
      print("tilecount----$tileCount");
      return adv_vol;
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

/////////////////////////////////////////////////////////////////////
  getQueueList(BuildContext context, int i) async {
    print("called------$i");

    try {
      Uri url = Uri.parse("http://$ip/API/queue_list2.php");
      // Uri url = Uri.parse("http://146.190.8.166/API/test_api.php");

      if (i == 0) {
        isListLoading = true;
        notifyListeners();
      }
      Map body = {'branch_id': br};
      print("body----$body");
      http.Response response = await http.post(url, body: body);
      var map = jsonDecode(response.body);
      queuetList.clear();
      queuetList1.clear();
      for (var item in map) {
        // if (item["isSpeak"] == "0") {
        queuetList.add(item);
        var map1 = {
          "queue_token": item["queue_token"],
          "cab_id": item["cab_id"],
          "queue_id": item["queue_id"],
          "msg": item["msg"],
          "voice_status": item["voice_status"],
          "isSpeak": "0"
        };
        queuetList1.add(map1);
        var map2 = {
          "queue_token": item["queue_token"],
          "cab_id": item["cab_id"],
          "queue_id": item["queue_id"],
          "msg": item["msg"],
          "voice_status": item["voice_status"],
          "isSpeak": "1"
        };
        queuetList1.add(map2);
        // // }
      }
      notifyListeners();

      print("quelist map11-----$queuetList1");

      selectedTile = List.generate(queuetList1.length, (index) => false);
      quelistReady = true;
      notifyListeners();
      if (i == 0) {
        isListLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

  ///////////////////////////////////////////
  updateList(BuildContext context, String str) async {
    try {
      Uri url = Uri.parse("http://$ip/API/update_list2.php");
      print("str----$str");
      Map body = {'arr': str};
      print("sssssbody----$body");
      http.Response response = await http.post(url, body: body);
      var map = jsonDecode(response.body);
      print("update list----$map");

      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

  setColor(int index, bool value) {
    selectedTile[index] = value;
    print("selectdhh-----${selectedTile[index]}");
    notifyListeners();
  }

  setSelectdeTile() {
    selectedTile = List.generate(queuetList.length, (index) => false);
    notifyListeners();
  }
}
