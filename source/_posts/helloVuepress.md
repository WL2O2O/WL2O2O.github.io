---
title: Vuepress 博客搭建
tags:
  - 网站搭建
categories:
  - Blog
abbrlink: 39f532c2
date: 2022-11-07 08:58:32
---

# 通过vuepress更新个人博客

## 博客搭建教程

> 本教程使用 pnpm 作为项目管理器，因为 VuePress 和 VuePress Theme Hope 都是通过 pnpm 来管理依赖的。

### 1、安装 Pnpm

在终端中输入下列命令安装 pnpm:

```bash
corepack enable
corepack prepare pnpm@latest --activate
```

### 2、初始化项目

```cmd
pnpm create vuepress-theme-hope my-docs
```

### 3、常用命令

- `vuepress dev [dir]` 会启动一个开发服务器，以便让你在本地开发你的 VuePress 站点。
- `vuepress build [dir]` 会将你的 VuePress 站点构建成静态文件，以便你进行后续部署。

> 使用模板
>
> 如果你在使用 VuePress Theme Hope 模板，你可以在 `package.json` 中发现下列三个命令:
>
> 
>
> ```json
> {
>   "scripts": {
>     "docs:build": "vuepress build src",
>     "docs:clean-dev": "vuepress dev src --clean-cache",
>     "docs:dev": "vuepress dev src"
>   }
> }
> ```
>
> 这意味着你可以使用:
>
> - `pnpm docs:dev` 启动开发服务器
> - `pnpm docs:build` 构建项目并输出
> - `pnpm docs:clean-dev` 清除缓存并启动开发服务器

### 4、 升级版本

如果你需要升级主题和 VuePress 版本，请执行以下命令:

```cmd
pnpm dlx vp-update
```

## 完善基本框架

### 1、了解基本结构

### 2、完善导航栏以及相关配置

3、



![](http://images.rl0206.love/202304181527666.png)

![](http://images.rl0206.love/202304192047438.png)

![](http://images.rl0206.love/202304221329083.ico)

### [评论插件：Waline](https://plugin-comment2.vuejs.press/zh/guide/waline.html)

#### 数据库

* 首先登录[leancloud](https://console.leancloud.app/apps)，注册数据库，记录`APP ID`,`APP Key` 和 `Master Key`以便后续使用；

#### 服务端

* 登录[Vercel](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fwalinejs%2Fwaline%2Ftree%2Fmain%2Fexample) 进行服务端部署，设置环境变量之后，重新部署，即可获得serveUrl。
  * 我获取到的服务端地址：https://cs-guider-6cmm99f2s-wl2o2o.vercel.app/

> 此时可以配置自己的域名，以便进行管理，不配置域名就通过以上服务端地址进行管理即可。
>
> **配置域名之后的管理网址**：
>
> - 评论系统：example.your-domain.com
> - 评论管理：example.your-domain.com/ui

#### 客户端

#### 使用插件

在插件选项中设置 `provider: "Waline"`，同时设置服务端地址 `serverURL` 为上一步获取到的值。

此时，将 `<CommentService>` 组件放置在你网站中合适的位置 (通常是页面的底部)，即可使用 Waline 评论功能。

提示

你也可以传入其他 Waline 支持的选项 (除了 `el`)。

详情请见 [Waline 配置](https://plugin-comment2.vuejs.press/zh/config/waline.html)

#### 评论管理 (管理端)

1. 部署完成后，请访问 `<serverURL>/ui/register` 进行注册。首个注册的人会被设定成管理员。
2. 管理员登陆后，即可看到评论管理界面。在这里可以修改、标记或删除评论。
3. 用户也可通过评论框注册账号，登陆后会跳转到自己的档案页。

### [评论插件：giscus](https://giscus.app/zh-CN)

#### 选择仓库

选择 giscus 连接到的仓库。请确保：

1. **此仓库是[公开的](https://docs.github.com/en/github/administering-a-repository/managing-repository-settings/setting-repository-visibility#making-a-repository-public)**，否则访客将无法查看 discussion。
2. **[giscus](https://github.com/apps/giscus) app 已安装**否则访客将无法评论和回应。
3. **Discussions**功能已[在你的仓库中启用](https://docs.github.com/en/github/administering-a-repository/managing-repository-settings/enabling-or-disabling-github-discussions-for-a-repository)。

仓库：（输入用户名/仓库名）

*一个**公开的（public）** GitHub 仓库。Discussion 将被连接到此仓库。*

#### 选择页面与嵌入的 discussion 之间的映射关系。

建议选择：**Discussion 的标题包含页面的 `pathname`**

#### Discussion 分类

选择新 discussions 所在的分类。 推荐使用**公告（announcements）**类型的分类，以确保新 discussion 只能由仓库维护者和 giscus 创建。

#### 启用 giscus

```js
<script src="https://giscus.app/client.js"
        data-repo="[在此输入仓库]"
        data-repo-id="[在此输入仓库 ID]"
        data-category="[在此输入分类名]"
        data-category-id="[在此输入分类 ID]"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="zh-CN"
        crossorigin="anonymous"
        async>
</script>
```

完成以上几项之后，上面代码段中会出现对应的repo、repoId、category、categoryId，复制下来，稍后有用。

在theme.ts中添加如下配置：

```
plugins：{
	comment: {
   		provider: "Giscus",
   		repo: "WL2O2O/CS_GUIDER_Giscus",
  		repoId: "your id",
   		category: "Announcements",
   		categoryId: "yours id"
 	 },
}
```

### 解决自动部署git pages：

新创建一个autopush.bat文件，将以下代码复制到文件中：

```bat
@echo off
git add .
git commit -m "update article"
git pull origin master
git push origin master
```

此时推送到gitee是正常的，但是推送之后，git pages的页面不会自动更新，于是经过百度，了解到可以通过Git的Webhooks功能，来实现git pages的自动更新。

了解一下webHook：

> 每次您 push 代码后，都会给远程 HTTP URL 发送一个 POST 请求 [更多说明 »](https://gitee.com/help/categories/40)
>
> WebHook 增加对钉钉的支持 [更多说明 »](https://gitee.com/help/articles/4135)
>
> WebHook 增加对企业微信的支持 [更多说明 »](https://gitee.com/help/articles/4296)
>
> WebHook 增加对飞书的支持 [更多说明 »](https://gitee.com/help/articles/4297)

以下是在Windows系统中使用Git的Webhooks功能自动更新Gitee Pages的步骤：

1. 在Gitee仓库的设置页面中，找到Webhooks设置，并添加一个新的Webhook，将Payload URL设置为你的博客页面的URL。
2. 在你的Vuepress博客项目中添加一个post-commit钩子脚本，用于向Gitee仓库发送Webhooks请求，触发Gitee Pages更新。在项目的.git/hooks目录中创建一个post-commit.bat文件，内容如下：

```bat
@echo off
curl -X POST https://gitee.com/api/v5/repos/{WLei224}/{WLei224}/hooks/{0c8adb9d-f0cf-450b-8d75-3cc56ac7bf3c}/trigger\?access_token\={583af4fe8a6611d418da106c6c8bae88}
```

将上述命令中的{用户名}、{仓库名}、{Webhook ID}和{访问令牌}替换为你自己的信息。其中，Webhook ID可以在Gitee仓库的Webhooks设置页面中找到，访问令牌可以在Gitee账号的个人设置页面中生成。

1. 为post-commit.bat文件添加可执行权限。在终端中进入项目的.git/hooks目录，执行以下命令：

```bash
chmod +x post-commit.bat
```

1. 推送代码到Gitee仓库，当你执行git commit命令后，post-commit.bat脚本会自动发送Webhooks请求，触发Gitee Pages更新。

通过上述步骤，你可以在Windows系统中实现自动更新Gitee Pages，提高博客发布的效率和便捷性。

### 博客引入思维导图

### Markmap

Markmap 是一个将 Markdown 转换为思维导图的工具。它相对于主题内置的 flowchart 支持更多的格式与内容。

1. 使用 [Markmapopen in new window](https://markmap.js.org/) 生成思维导图 HTML 文件（安装markmap插件，可以以思维导图的图形预览markdown文件，然后可选是否导出为html文件）
2. 将 HTML 文件放在 `.vuepress/public/` 下
3. 通过 `<iframe>` 插入到 Markdown

输入:

```html
<iframe
  :src="$withBase('/markmap/demo-zh.html')"
  width="100%"
  height="400"
  frameborder="0"
  scrolling="No"
  leftmargin="0"
  topmargin="0"
/>
```

输出:

<iframe src="/markmap/demo-zh.html" width="100%" height="800" frameborder="0" scrolling="No" leftmargin="0" topmargin="0"></iframe>

------



### 尝试缩短博客构建时间的方法（以下是GPT生成的步骤，待测试！）

VuePress 使用的是 Webpack 构建工具，而使用 pnpm 作为包管理器则可以大幅缩短安装依赖包的时间。然而，如果在使用 pnpm 构建 VuePress 网站时仍然遇到了速度很慢的问题，可以尝试以下几个方法：

1. 更新 pnpm 版本：首先，您可以尝试升级 pnpm 的版本。较新的版本通常会修复一些问题并提高性能。您可以使用以下命令来更新 pnpm：


   ````
   npm i -g pnpm@latest
   ````

2. 切换镜像源：如果您使用的是国外的包管理器镜像源，可能会导致下载速度很慢。您可以尝试切换到国内的镜像源，例如淘宝镜像、cnpmjs 等。您可以使用以下命令来设置淘宝镜像源：

   ````
   pnpm config set registry https://registry.npm.taobao.org
   ````
   
3. 使用缓存：在第一次构建 VuePress 网站时，pnpm 会下载所有依赖包，并且可能会需要很长时间。一种解决方法是使用缓存，在下一次构建时从缓存中加载依赖包而不是重新下载。您可以使用以下命令来启用缓存：

   ````
   pnpm install --shamefully-hoist --store-dir=./.pnpm-store
   
   在第一次构建时，pnpm 会将依赖包缓存到指定的目录中。在下一次构建时，pnpm 将从缓存中加载依赖包，而不是重新下载。
   ````
   
4. 升级 Node.js 版本：VuePress 需要使用较新的版本的 Node.js，如果您的 Node.js 版本太旧，可能会导致构建速度变慢。您可以尝试将 Node.js 版本升级到最新版，并重新构建 VuePress 网站。

5. 按需加载：如果您的 VuePress 网站包含大量的页面和组件，可以尝试使用按需加载来提高构建速度。您可以使用 VuePress 的 `async` 组件来实现按需加载，例如：

   ````
   <AsyncContent path="./path/to/file.vue" />
   ```
   
   这将使 VuePress 仅在需要时才加载组件，而不是在构建时将所有组件都打包进最终的 JavaScript 文件中。
   ````

以上是一些可以尝试的方法来提高使用 pnpm 构建 VuePress 网站的速度。如果以上方法仍然无法解决您的问题，您可以尝试在 VuePress 官方的 GitHub 仓库中搜索类似的问题，或者在 VuePress 社区中询问其他人是否遇到了类似的问题并得到了解决方法。


### 要在 VuePress 中集成百度统计，您需要遵循以下步骤：

在百度统计中创建站点并获取统计代码：首先，您需要在百度统计中创建一个站点，并获取相应的统计代码。在百度统计管理面板中，选择您要添加统计代码的站点，然后单击“代码管理”按钮。在“统计代码”页面中，您将看到一段 JavaScript 代码。复制该代码以备后用。

在 VuePress 中创建配置文件：接下来，您需要在 VuePress 项目中创建一个配置文件。在您的 VuePress 项目根目录下，创建一个名为 .vuepress 的文件夹，然后在该文件夹中创建一个名为 config.js 的配置文件。在 config.js 文件中添加以下代码：

```
module.exports = {
  head: [
    ['script', {}, `
      var _hmt = _hmt || [];
      (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?YOUR_BAIDU_SITE_ID";
        var s = document.getElementsByTagName("script")[0]; 
        s.parentNode.insertBefore(hm, s);
      })();
   `]
  ]
}
```

在代码中，将 `YOUR_BAIDU_SITE_ID` 替换为您在百度统计中创建站点时获得的站点 ID。

将配置文件添加到 Git 仓库并部署网站：完成上述步骤后，将创建的 .vuepress 文件夹和其中的 config.js 文件添加到您的 Git 仓库中，并将网站部署到您的服务器或托管平台上。如果您使用的是 GitHub Pages，您可以将 .vuepress 文件夹和其中的 config.js 文件添加到您的 GitHub 仓库中，并在仓库的设置页面中将 GitHub Pages 的源设置为“master branch /docs folder”。

验证是否成功添加了百度统计：最后，您可以访问您的网站并登录到百度统计管理面板中，查看是否有网站访问数据。如果一切正常，您应该能够在百度统计中看到您网站的访问数据和用户行为数据。

以上是在 VuePress 中集成百度统计的步骤和代码示例。请注意，由于百度统计的代码可能会随时更新，所以建议您在将代码添加到您的 VuePress 项目中之前，先阅读并遵循百度统计的官方文档。另外，您还可以使用 VuePress 插件来方便地集成百度统计，例如 vuepress-plugin-baidu-analytics 插件。此插件可以自动在您的 VuePress 网站中添加百度统计代码，而无需手动编辑配置文件。您可以在 VuePress 插件市场中搜索该插件，并按照其文档说明进行安装和配置。



### 站长工具：百度资源搜索平台

> ***网站言则会那个不通过的问题：***

在平台添加网站时，需要进行文件或者HTML标签进行验证，之前一直验证都不通过，昨天（23年/5月26日）根据报错信息，终于验证通过了，我选择的验证方式是文件验证，因为在vuepress博客中构建的每一个html文件添加相应的标签，我还没有找到合适的方法，于是就通过文件验证的方法进行了相关的验证，

刚开始按照网站的提示，将验证文件放在网站的根目录下，然后按要求照做了，结果是一直未验证通过。点击确认验证文件可以正常访问，也访问不到相应的验证文件，然后就想着还是路径不对，然后求助了`ChatGpt`,把验证文件换了一个路径进行上传，然后问题就解决了！！！

> ***API 提交和 Sitemap 提交应该选择哪一个？***

API 提交和 Sitemap 提交都可以帮助搜索引擎更好地收录和展示您的网站数据，但是它们的作用和适用场景略有不同。

API 提交是指通过将网站数据以 API 接口的形式提供给搜索引擎，让搜索引擎可以更及时、准确地获取网站数据。API 提交通常适用于动态内容和实时数据的网站，比如新闻、社交媒体、股票行情等。API 提交可以让搜索引擎更快地获取网站数据，从而更及时地更新搜索结果，提高网站曝光度和流量。

Sitemap 提交是指将网站的 Sitemap 文件提交给搜索引擎，以便搜索引擎更好地了解网站的结构和内容。Sitemap 提交通常适用于静态内容和定期更新的网站，比如博客、电商网站、企业网站等。Sitemap 提交可以让搜索引擎更快地了解网站的结构和内容，从而更好地收录和展示网站的信息，提高网站的可见性和搜索排名。

综合来说，API 提交和 Sitemap 提交都可以提高网站的曝光度和流量，但是它们的适用场景略有不同。对于动态内容和实时数据的网站，API 提交更为适用；对于静态内容和定期更新的网站，Sitemap 提交更为适用。在实际应用中，可以根据网站的特点和需求，选择合适的提交方式来促进网站的发展和成长。



### 域名备案需要服务器IP的问题

> 必须要有服务器吗？

根据中国互联网信息办公室的规定，如果您的个人博客使用的域名在中国大陆境内进行访问，需要进行备案才能正常访问。备案需要提供服务器的信息，包括服务器所在地、服务器的 IP 地址、备案主体信息等。

如果您的个人博客部署在 GitHub Pages 或其他类似的静态网站托管服务上，而没有自己的服务器，那么备案可能会有一定的困难。因为备案需要提供服务器的信息，如果没有自己的服务器，就无法提供这些信息。此时，您可以考虑购买虚拟主机或云服务器等产品，然后将个人博客迁移到这些服务器上，再进行备案。

在购买虚拟主机或云服务器时，您可以选择腾讯云或其他云服务提供商，根据自己的需求选择合适的产品类型和配置，然后将个人博客部署到服务器上。备案完成后，将域名解析到服务器的 IP地址，就可以正常访问个人博客了。

需要注意的是，备案需要提供真实的备案主体信息，包括个人或单位的营业执照、身份证等证件，如果您是个人用户，需要提供有效的身份证件。因此，在进行备案之前，建议先了解备案的相关规定和流程，准备好备案所需的材料和信息，以免出现不必要的麻烦。

另外，备案是一个比较复杂的过程，需要注意各个环节的细节。如果您对备案流程和规定不熟悉，建议咨询相关专业人士或官方机构的客服人员，以避免出现不必要的错误和问题。

