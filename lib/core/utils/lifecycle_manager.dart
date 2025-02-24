import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';

class LifecycleManager extends StatefulWidget {
  final Widget child;

  const LifecycleManager({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LifecycleManager> createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      AuthLocalDataSource().removeAuthData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
