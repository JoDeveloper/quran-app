import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_tutorial/globalhelpers/constants.dart';

class QuranPage extends StatefulWidget {
  final Map<String, dynamic> suraJsonData;

  const QuranPage({super.key, required this.suraJsonData});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int selectedSuraIndex = 0;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredSurahs = widget.suraJsonData.entries
        .where(
          (entry) => entry.value['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: quranPagesColor,
      appBar: AppBar(
        backgroundColor: quranPagesColor,
        title: const Text('Select Surah'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Surah...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                final surah = filteredSurahs[index];
                final surahName = surah.value['name'] as String;
                final surahNameTranslated =
                    surah.value['nameTranslated'] as String?;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: ListTile(
                    title: Text(
                      surahName,
                      style: TextStyle(
                        fontFamily: 'QuranFont',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: surahNameTranslated != null
                        ? Text(
                            surahNameTranslated,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          )
                        : null,
                    trailing: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        surah.key,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigate to Quran page with selected surah
                      Navigator.pop(context, surah.key);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
