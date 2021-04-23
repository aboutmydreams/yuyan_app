import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:yuyan_app/model/document/toc/toc_seri.dart';

class BookTocTreeWidget extends StatelessWidget {
  final List<TocSeri> data;

  const BookTocTreeWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TreeView(
      indent: 28,
      nodes: _buildNodes(data),
    );
  }

  Widget _buildNode(TocSeri node) {
    return Container(
      child: Text('${node.title}'),
    );
  }

  List<TreeNode> _buildNodes(List<TocSeri> data) {
    Map<String, TocSeri> map = {};
    data.forEach((toc) {
      map[toc.uuid] = toc;
    });
    var root = TreeNode(children: []);
    _parse(map, root, data.first);
    return root.children;
  }

  _parse(
    Map<String, TocSeri> map,
    TreeNode parent,
    TocSeri child,
  ) {
    //确保children已经初始化了
    var node = TreeNode(
      content: _buildNode(child),
      children: [],
    );
    parent.children.add(node); //将自己添加进入父节点
    var nc = map[child.childUuid];
    if (nc != null) {
      //现在这个节点充当父节点
      //进行递归，优先处理子节点
      _parse(map, node, nc);
    }
    //第一个兄弟节点
    var sib = map[child.siblingUuid];
    while (sib != null) {
      var sibNode = TreeNode(
        content: _buildNode(sib),
        children: [],
      );
      parent.children.add(sibNode);
      var nc = map[sib.childUuid];
      if (nc != null) {
        _parse(map, sibNode, nc);
      }
      //下一个兄弟节点
      sib = map[sib.siblingUuid];
    }
  }
}
