String clearText(String text, int maxn) {
  // RegExp exp = new RegExp(r'<[^>]+>');
  String retext = text.replaceAll("\n", "");
  // String retext = text
  //     .replaceAll(exp, "")
  //     .replaceAll("\n\n", "")
  //     .replaceAll("&nbsp", "")
  //     .replaceAll("</", "");
  //.replaceFirst("\n", "", text.length ~/ 2)

  if (retext.length > maxn) {
    // retext = retext.substring(0, maxn) + "..";
    retext = retext.substring(0, maxn - 2) + "..";
  }
  return retext;
}
