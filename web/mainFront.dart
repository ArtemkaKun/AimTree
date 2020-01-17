import "dart:html";
import 'dart:svg';
import 'package:AimTree/AimCircle.dart' as AimCircle;
import 'package:AimTree/Global.dart';

final DivElement _canvas = GetCanvas();
final SvgElement _svg = GetSvg();

main() {
  _canvas.onClick.listen(CanvasClicker);

  _svg.attributes = {
    "width": "100%",
    "height": "100%",
  };

  _canvas.children.add(_svg);

  querySelector("#select_tool").onClick.listen(GetToolPanel().SelectButton);
  querySelector("#add_tool").onClick.listen(GetToolPanel().AddButton);
  querySelector("#remove_tool").onClick.listen(GetToolPanel().RemoveButton);
}

void CanvasClicker(MouseEvent event) {
  if (event.target == _svg && GetToolPanel().GetIsAddTool()) {
    print("Here!");
    AimCircle.AimCircle new_aim = new AimCircle.AimCircle(event.client.x,
        event.client.y);
    SetCircleNumber(GetCircleNumber() + 1);
    _canvas.children.add(new_aim.GetOneAimCircle());
  }
}
