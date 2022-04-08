import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'members.dart';
import 'strings.dart' as strings;

class GHFlutter extends StatefulWidget {
  const GHFlutter({Key? key}) : super(key: key);

  @override
  State<GHFlutter> createState() => _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  final _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future<void> _loadData() async {
    const dataUrl =
        'https://api.weatherbit.io/v2.0/forecast/daily?city=london&key=38ff7a5f9aa44a4fb8a39690b036d5cb';
    final response = await http.get(Uri.parse(dataUrl));
    final dataList = json.decode(response.body) as Map<String, dynamic>;
    print(dataList['city_name']);
    print(dataList['data'][0]);
    // setState(() {
    //   final dataList = json.decode(response.body);
    //   for (final item in dataList) {
    //     final login = item['login'] as String? ?? '';
    //     final url = item['avatar_url'] as String? ?? '';
    //     final members = Member(login, url);
    //     _members.add(members);
    //   }
    // });
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[i].avaterUrl),
        ),
        title: Text(_members[i].login, style: _biggerFont),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }
}
