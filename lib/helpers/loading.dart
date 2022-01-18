import 'package:flutter/material.dart';

import 'ColorHelpers.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 85,
        height: 85,
        child: CircularProgressIndicator(
          // backgroundColor: ColorsHelper.mainColors,
          valueColor: AlwaysStoppedAnimation(
            ColorsHelper.GreenColor,
          ),
        ),
      ),
    );
  }
}
