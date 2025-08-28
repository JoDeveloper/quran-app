import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_tutorial/globalhelpers/constants.dart';
import 'package:quran_tutorial/views/quran_sura_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? jsonData;

  Future<void> loadJsonAsset() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/surahs.json',
      );
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      if (mounted) {
        setState(() {
          jsonData = data;
        });
      }
    } catch (e) {
      debugPrint('Error loading JSON: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadJsonAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quranPagesColor,
      body: Center(
        child: ElevatedButton(
          onPressed: jsonData != null
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => QuranPage(suraJsonData: jsonData!),
                    ),
                  );
                }
              : null,
          child: Text(jsonData != null ? "Go To Quran Page" : "Loading..."),
        ),
      ),
    );
  }
}
