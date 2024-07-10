import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simply_poem/screens/home/search_result_screen.dart';
import 'package:simply_poem/utils/app_text.dart';
import 'package:simply_poem/utils/constants/pallete.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _ageRange = const RangeValues(18, 60);
  double _distance = 50.0;
  double _weight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.filterProfiles),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppText.ageRange,
              style:
                  StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
            ),
            RangeSlider(
              values: _ageRange,
              min: 18,
              max: 100,
              divisions: 82,
              labels: RangeLabels(
                  '${_ageRange.start.round()}', '${_ageRange.end.round()}'),
              onChanged: (RangeValues values) {
                setState(() {
                  _ageRange = values;
                });
              },
            ),
            20.verticalSpace,
            Text(
              AppText.distance,
              style:
                  StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
            ),
            Slider(
              value: _distance,
              min: 1,
              max: 100,
              divisions: 99,
              label: _distance.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _distance = value;
                });
              },
            ),
            20.verticalSpace,
            Text(
              AppText.weight,
              style:
                  StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
            ),
            Slider(
              value: _weight,
              min: 30,
              max: 200,
              divisions: 170,
              label: _weight.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _weight = value;
                });
              },
            ),
            40.verticalSpace,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(
                        ageRange: _ageRange,
                        distance: _distance,
                        weight: _weight,
                      ),
                    ),
                  );
                },
                child: const Text(AppText.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
