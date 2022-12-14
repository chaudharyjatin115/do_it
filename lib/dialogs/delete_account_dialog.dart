import 'package:flutter/material.dart' show BuildContext;
import 'package:do_it/dialogs/generic_dialogs.dart';

Future<bool?> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'Delete Account',
      content: 'are you sure you want to delete your account?',
      optionsBuilder: () => {
            // key        value
            'cancel': false,
            'Delete account': true,
          }).then((value) => value ?? false);
}
