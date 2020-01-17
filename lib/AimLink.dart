import 'dart:html';
import 'dart:svg';
import 'package:AimTree/Global.dart';
import 'package:AimTree/AimCircle.dart' as AimCircle;

class AimLink {
  final List<AimCircle.AimCircle> _connected_aims =
      new List<AimCircle.AimCircle>(2);
  //final SvgElement _svg = new SvgElement.tag("svg");  //Actual svg wrapper
  final SvgElement _line_connection = new SvgElement.tag("line"); //Actual svg line parameter

  int _X1;
  int _Y1;
  int _X2;
  int _Y2;

  AimLink(AimCircle.AimCircle first_aim_circle, AimCircle.AimCircle second_aim_circle) {
    _connected_aims[0] = first_aim_circle;
    _connected_aims[1] = second_aim_circle;

    //First circle coordinates
    _X1 = _connected_aims[0].GetXPos();
    _Y1 = _connected_aims[0].GetYPos();

    //Second circle coordinates
    _X2 = _connected_aims[1].GetXPos();
    _Y2 = _connected_aims[1].GetYPos();

    //Set main lines parameter
    _line_connection.attributes = {
      "x1": "${_X1}",
      "y1": "${_Y1}",
      "x2": "${_X2}",
      "y2": "${_Y2}",
      "stroke": "#707070",
      "stroke-width": "5",
    };

    _line_connection.onClick.listen(OnMouseClick);

    GetSvg().nodes.add(_line_connection); //add line to main svg canvas
    GetToolPanel().RemoveSelection(); //remove selection from circles
  }

  void OnMouseClick(MouseEvent event) {
    if (event.ctrlKey) {
      this._line_connection.remove();
    }
  }
}
