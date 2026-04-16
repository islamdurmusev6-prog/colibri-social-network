import '../bloc/settings/user_setting_cubit.dart';
import '../pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyScreen extends StatefulWidget {
  final List<PrivacyWidgetModel>? privacyModels;

  const PrivacyScreen({Key? key, this.privacyModels}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  late UserSettingCubit userSettingCubit;
  @override
  void initState() {
    super.initState();
    userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
