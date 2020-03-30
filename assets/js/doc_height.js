window.flutter_inappbrowser.callHandler('InAppWebView', document.body.scrollHeight)
console.log("=======我是js======")

window.addEventListener("flutterInAppBrowserPlatformReady", function (event) {
    // call flutter handler with name 'mySum' and pass one or more arguments
    window.flutter_inappbrowser.callHandler('mySum', 12, 2, 50).then(function (result) {
        // get result from Flutter side. It will be the number 64.
        console.log(result);
    });
});