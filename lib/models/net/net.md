# 网络请求


## 包含 Cookie 的请求 

其他 使用 _yuque_session 作为 Cookie 放在 header 中。

使用 DioReq 类，封装了 get、post、put、delete 方法。

为了使用方便，我将 x-csrf-token 也放在了 header 中方便 V2 api 调用。

## V2 api

一些 V2 api 封装在 requests_api 当中。

注意一点，V2 api 当中许多都是需要 `login` 或 用户 `id` 作为 url 参数的。

而`login` 与 `id` 在 我的页面初始化时才刷新缓存，因此调用相关 api 的操作
需要放在我的页面初始化之后。

之所以不在 oauth2 的模块中完成这一步是因为我考虑到 `login` 可能会更改，而
oauth2 持久化登录操作仅需初始一次，顾才采用了放在初始化中每次刷新。