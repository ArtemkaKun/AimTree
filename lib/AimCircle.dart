import 'dart:html';
import 'package:AimTree/AimLink.dart';
import 'package:AimTree/Global.dart';

//Class of aim circle
class AimCircle {
  //Private variables
  final DivElement _one_aim_circle = new DivElement();
  final SpanElement _aim_text = new SpanElement();
  final DivElement _canvas = GetCanvas(); //main canvas

  int _posX; //position of circle div
  int _posY; //position of circle div
  double _circle_scale = 1;
  double _previous_scale_mouse_pos = 0;

  bool _is_selected = false;
  bool _is_active_aim = false;

  String _circle_id;

  var listen_canvas_move; //Store onMouseMove listeners for main canvas
  //Need for drag and scale functions work properly

  //Class constructor start here
  AimCircle(var posX, var posY) {
    _posX = posX;
    _posY = posY;
    _circle_id = "circle${GetCircleNumber()}";

    //Set main circle attributes
    _one_aim_circle.id = _circle_id;
    _one_aim_circle.className = "circle";

    _one_aim_circle.style.top = "${_posY - 50}px";
    _one_aim_circle.style.left = "${_posX - 50}px";

    //Set MouseClick functions
    _one_aim_circle.onClick.listen(CircleOnClick);
    _one_aim_circle.onMouseDown.listen(CircleMouseDown);
    _one_aim_circle.onMouseUp.listen(CircleMouseUp);

    _canvas.onMouseUp.listen(CanvasMouseUp); //Need for scale function work

    AimText(); //Create an text element inside circle

    document.body
        .append(_one_aim_circle); //create DOM element and add it to HTML
  }

  void CircleOnClick(MouseEvent event) {
    bool is_selected_tool = GetToolPanel().GetIsSelectTool();

    if (is_selected_tool && event.altKey && event.ctrlKey) {
      if (!_is_active_aim) {
        _is_active_aim = true;
        _one_aim_circle.style.border = "3px solid green";
      } else {
        _is_active_aim = false;
        _one_aim_circle.style.border = "none";
      }
    } else if (is_selected_tool && event.ctrlKey) {
      if (!_is_selected) {
        _is_selected = true;
        _one_aim_circle.style.border = "3px solid blue";
        GetSelectedCircleBuffer().add(this);
        if (GetSelectedCircleBuffer().length == 2) {
          AimLink(GetSelectedCircleBuffer()[0], GetSelectedCircleBuffer()[1]);
        }
      } else {
        _is_selected = false;
        _one_aim_circle.style.border = "none";
        GetSelectedCircleBuffer().remove(this);
      }
    } else if (is_selected_tool && event.altKey) {
      CreateAimTextInput();
    } else if (GetToolPanel().GetIsRemoveTool()) {
      querySelector("#${this._circle_id}").remove();
      SetCircleNumber(GetCircleNumber() - 1);
    }
  }

  void CircleMouseDown(MouseEvent event) {
    bool is_selected_tool = GetToolPanel().GetIsSelectTool();

    if (is_selected_tool && !event.ctrlKey && !event.shiftKey) {  //if no keys pressed - can free move aim circle on canvas
      listen_canvas_move = _canvas.onMouseMove.listen((MouseEvent event) {
        event.preventDefault();

        _one_aim_circle.style.top = "${event.client.y - 50}px";
        _one_aim_circle.style.left = "${event.client.x - 50}px";

        _posX = event.client.x;
        _posY = event.client.y;
      });
    } else if (is_selected_tool && event.shiftKey) {  //if shift pressed - scale mode
      listen_canvas_move = _canvas.onMouseMove.listen((MouseEvent event) {
        event.preventDefault();

        double buff = ((_posY - event.client.y) * -1) / 1500;
        if (_previous_scale_mouse_pos < buff) {
          _circle_scale += buff;
          _previous_scale_mouse_pos = buff;
        } else if (_previous_scale_mouse_pos > buff) {
          _circle_scale -= buff;
          _previous_scale_mouse_pos = buff;
        }

        _one_aim_circle.style.transform = "scale(${_circle_scale}, ${_circle_scale})";
      });
    }
  }

  void CircleMouseUp(MouseEvent event) {
    if (GetToolPanel().GetIsSelectTool() && !event.ctrlKey) {
      listen_canvas_move.cancel();
    }
  }

  void CanvasMouseUp(MouseEvent event) {
    if (GetToolPanel().GetIsSelectTool() && !event.ctrlKey) {
      listen_canvas_move.cancel();
      _previous_scale_mouse_pos = 0;
    }
  }

  //Create an text element inside circle. Also is responsible for name input form
  void AimText() {
    CreateAimTextInput();

    //Set main aim text element attributes
    _aim_text.id = "${_circle_id}_aim_text";
    _aim_text.style.textAlign = "center";

    _one_aim_circle.children.add(_aim_text); //Add aim text to circle
  }

  //Create aim text input form
  void CreateAimTextInput() {
    //Create input form: main span, input string and action button
    final SpanElement user_aim_text_input = new SpanElement();
    final InputElement input_field = new InputElement();
    final ButtonElement set_text_button = new ButtonElement();

    //Set main span element attributes
    user_aim_text_input.id = "user_aim_text_input";

    user_aim_text_input.style.position = "absolute";
    user_aim_text_input.style.zIndex = "2";
    user_aim_text_input.style.textAlign = "center";
    user_aim_text_input.style.height = "3%";
    user_aim_text_input.style.top = "${_posY - 50}px";
    user_aim_text_input.style.left = "${_posX + 50}px";

    user_aim_text_input.children.add(input_field); //Add input field to span
    user_aim_text_input.children.add(set_text_button); //Add button to span

    //Set main input string attributes
    input_field.id = "aim_name";

    input_field.style.display = "inline";

    //Set main button attributes
    set_text_button.text = "Set name";
    set_text_button.style.display = "inline";

    //Create action button click function
    set_text_button.onClick.listen((MouseEvent event) {
      querySelector("#${this._circle_id}_aim_text").text =
          (querySelector("#aim_name") as InputElement)
              .value; //Need query as InputElement (default it get Element)
      //Because we need to get input field value
      querySelector("#user_aim_text_input").remove(); //Close this input form
    });

    document.body
        .append(user_aim_text_input); //create DOM element and add it to HTML
  }

  void SetIsSelected(bool value) {
    _is_selected = value;
  }

  bool GetIsSelected() => _is_selected;

  DivElement GetOneAimCircle() => _one_aim_circle;

  int GetXPos() => _posX;
  int GetYPos() => _posY;
}
