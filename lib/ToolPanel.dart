import 'dart:html';
import 'package:AimTree/AimCircle.dart' as AimCircle;
import 'package:AimTree/Global.dart';

//Class of side tool panel
class ToolPanel {
  //Private variables
  bool _select_tool = false;
  bool _add_tool = false;
  bool _remove_tool = false;

  //Constructor, but it doesn't do anything
  ToolPanel() {

  }

  void SelectButton(MouseEvent event) {
    _select_tool = true;
    _add_tool = false;
    _remove_tool = false;
    
    querySelectorAll(".tool_button")[0].style.border = "2px solid red";
    querySelectorAll(".tool_button")[1].style.border = "none";
    querySelectorAll(".tool_button")[2].style.border = "none";
  }

  void AddButton(MouseEvent event) {
    _select_tool = false;
    _add_tool = true;
    _remove_tool = false;

    RemoveSelection();
    querySelectorAll(".tool_button")[1].style.border = "2px solid red";
    querySelectorAll(".tool_button")[0].style.border = "none";
    querySelectorAll(".tool_button")[2].style.border = "none";
  }

  void RemoveButton(MouseEvent event) {
    _select_tool = false;
    _add_tool = false;
    _remove_tool = true;

    RemoveSelection();
    querySelectorAll(".tool_button")[2].style.border = "2px solid red";
    querySelectorAll(".tool_button")[1].style.border = "none";
    querySelectorAll(".tool_button")[0].style.border = "none";
  }

  //Remove all selection from aim_circles
  void RemoveSelection() {
    List<AimCircle.AimCircle> selected_circle_buffer =
        GetSelectedCircleBuffer();

    if (selected_circle_buffer.length != 0) {
      for (AimCircle.AimCircle one_selected_aim in selected_circle_buffer) {
        one_selected_aim.SetIsSelected(false);
        one_selected_aim.GetOneAimCircle().style.border = "none";
      }
      selected_circle_buffer.clear();
    }
  }

  bool GetIsSelectTool() => _select_tool; //short form of simple return function

  bool GetIsAddTool() => _add_tool; //short form of simple return function

  bool GetIsRemoveTool() => _remove_tool; //short form of simple return function
}
