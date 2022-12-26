import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_project/examples/sliver_bottom_sheet/widgets/sliver_group/src/render/render_sliver_group.dart';

@immutable
class SliverGroup extends RenderObjectWidget {
  const SliverGroup(
      {Key? key,
        this.margin,
        this.borderRadius,
        this.decorationWidget,
        this.sliver})
      : super(key: key);

  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Widget? decorationWidget;
  final Widget? sliver;

  @override
  RenderSliverGroup createRenderObject(BuildContext context) {
    return RenderSliverGroup(
        margin: margin??EdgeInsets.zero, borderRadius: borderRadius);
  }

  @override
  SliverGroupElement createElement() => SliverGroupElement(this);

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverGroup renderObject) {
    renderObject
      ..margin = margin!
      ..borderRadius = borderRadius;
  }
}

class SliverGroupElement extends RenderObjectElement {
  SliverGroupElement(SliverGroup widget) : super(widget);

  Element? _decoration;
  Element? _sliver;

  @override
  SliverGroup get widget => super.widget as SliverGroup;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_decoration != null) visitor(_decoration!);
    if (_sliver != null) visitor(_sliver!);
  }

  @override
  void forgetChild(Element child) {
    if (child == _decoration) _decoration = null;
    if (child == _sliver) _sliver = null;
  }

  @override
  void mount(Element? parent, newSlot) {
    super.mount(parent, newSlot);
    _decoration = updateChild(_decoration, widget.decorationWidget, 0);
    _sliver = updateChild(_sliver, widget.sliver, 1);
  }

  @override
  void update(RenderObjectWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _decoration = updateChild(_decoration, widget.decorationWidget, 0);
    _sliver = updateChild(_sliver, widget.sliver, 1);
  }

  @override
  void insertRenderObjectChild(RenderObject child, int? slot) {
    final RenderSliverGroup renderObject = this.renderObject as RenderSliverGroup;
    if (slot == 0) renderObject.decoration = child as RenderBox?;
    if (slot == 1) renderObject.child = child as RenderSliver?;
    assert(renderObject == this.renderObject);
  }

  @override
  void moveChildRenderObject(RenderObject child, slot) {
    assert(false);
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    final RenderSliverGroup renderObject = this.renderObject as RenderSliverGroup;
    if (renderObject.decoration == child) renderObject.decoration = null;
    if (renderObject.child == child) renderObject.child = null;
    assert(renderObject == this.renderObject);
  }
}