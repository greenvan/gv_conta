import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String label, route;
  final Icon icon;
  final Object arguments;
  const HomeButton(
      {@required this.label,
      @required this.icon,
      @required this.arguments,
      @required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: 80,
        width: 220,
        child: RaisedButton.icon(
          icon: icon,
          label: Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          textColor: Colors.white70,
          elevation: 12,
          onPressed: () {
            Navigator.of(context).pushNamed(route, arguments: arguments);
          },
        ),
      ),
    );
  }
}
