part of '../attion_flutter_tools.dart';

class SelectedButton extends StatelessWidget {
  final bool selected;
  final String text;
  final ValueChanged<String> callback;
  final double fontSize;
  SelectedButton({this.selected = false, this.text = 'button',this.fontSize=24,@required this.callback})
      : super();

  @override
  Widget build(BuildContext context) {
    var pcr = Theme.of(context).primaryColor;
    if (selected) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: RaisedButton(
          child: Text(text,style: TextStyle(fontSize: fontSize),),

          color: pcr,
          textColor: Colors.white,
          onPressed: (){
            callback(text);
          },//,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: OutlineButton(
          child: Text(text,style: TextStyle(fontSize: fontSize),),
          borderSide: BorderSide(color: pcr),
          textColor: pcr,
          onPressed: (){
            callback(text);
          },
        ),
      );
    }
  }
}