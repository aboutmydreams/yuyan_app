import 'package:flutter/material.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/views/explore_page/data/selection_data.dart';

Widget firstItemUI(Data data) {
  return Container(
    height: 213,
    margin: EdgeInsets.only(left: 18, top: 9, right: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: 164,
            child: FadeInImage.assetNetwork(
              image: data.cover,
              placeholder: 'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Spacer(),
        Container(
          height: 39,
          margin: EdgeInsets.only(right: 47),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(128, 116, 116, 116),
                          offset: Offset(0, 0),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        image: data.user.smallAvatarUrl,
                        placeholder: 'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 38,
                    margin: EdgeInsets.only(left: 14, bottom: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clearText(data.title, 24),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "PingFang SC",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "${data.user.name} 发布于 ${data.book.name}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black45,
                            fontFamily: "PingFang SC",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
