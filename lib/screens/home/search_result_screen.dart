import 'package:flutter/material.dart';
import 'package:simply_poem/services/search_result_services/search_result_services.dart';
import 'package:simply_poem/utils/app_text.dart';
import 'package:simply_poem/utils/constants/pallete.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';

class SearchResultsScreen extends StatelessWidget {
  final RangeValues ageRange;
  final double distance;
  final double weight;

  const SearchResultsScreen({
    super.key,
    required this.ageRange,
    required this.distance,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.searchResults),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future:
            SearchResultsService().searchProfiles(ageRange, distance, weight),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style:
                  StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              AppText.noProfile,
              style:
                  StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
            ));
          } else {
            return ListView(
              children: snapshot.data!.map((data) {
                return ListTile(
                  leading: CircleAvatar(
                      child: Image.network(
                    data['profile'],
                    fit: BoxFit.fill,
                  )),
                  title: Text(
                    data['username'] ?? 'Unknown',
                    style: StyleConstants.headerTextStyle
                        .copyWith(color: Pallete.black),
                  ),
                  subtitle: Text(
                    'Age: ${data['age'] ?? 'Unknown'}, Distance: ${data['distance']} km, Weight : ${data['weight']}',
                    style: StyleConstants.headerTextStyle
                        .copyWith(color: Pallete.black),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
