import 'package:flutter/cupertino.dart';

class RegistryDetails extends StatelessWidget {
  static const String routeName = "registry_details";
  const RegistryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {}
    return const Placeholder();
  }
}
