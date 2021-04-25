import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/toc/toc_seri.dart';

class BookTocTreeWidget extends StatelessWidget {
  final BookSeri book;
  final List<TocSeri> data;
  final _controller = TreeController(allNodesExpanded: false);

  BookTocTreeWidget({
    Key key,
    this.book,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: TreeView(
        indent: 28,
        nodes: _buildNodes(data),
        treeController: _controller,
      ),
    );
  }

  Widget _buildNode(TocSeri node) {
    final child = Container(
      child: Text('${node.title}'),
    );

    return GestureDetector(
      onTap: () {
        switch (node.type) {
          case 'TITLE':
            break;
          case 'LINK':
            MyRoute.webview(node.url, yuque: false);
            return;
          case 'DOC':
            MyRoute.docDetailWebview(
              bookId: book.id,
              slug: node.url,
              login: book.user.login,
              book: book.slug,
            );
            return;
        }
      },
      child: child,
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
