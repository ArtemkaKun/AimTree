import 'dart:html';
import 'dart:svg';
import 'package:AimTree/ToolPanel.dart' as Tools;
import 'package:AimTree/AimCircle.dart' as AimCircle;

final Tools.ToolPanel _tools_panel = new Tools.ToolPanel();
final DivElement _canvas = querySelector("#canvas");
final SvgElement _svg = new SvgElement.tag("svg");  //Actual svg wrapper

int _circle_number = 0;

List<AimCircle.AimCircle> _selected_circle_buffer = <AimCircle.AimCircle>[];
Tools.ToolPanel GetToolPanel() => _tools_panel; //short form of simple return function
List<AimCircle.AimCircle> GetSelectedCircleBuffer() => _selected_circle_buffer; //short form of simple return function

void SetCircleNumber(int value) {
  _circle_number = value;
}

int GetCircleNumber() => _circle_number; //short form of simple return function
DivElement GetCanvas() => _canvas;
SvgElement GetSvg() => _svg;