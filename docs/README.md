<https://clsty.github.io/arCNiso>

# 开发

当前，此文档系统基于 Starlight，而它又基于前端框架 Astro。

## 本地运行

| 命令                   | 作用                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

> [!NOTE]
> 若报错 `vips/vips8: no such file or directory`，可以手动安装 `libvips`，比如对于 Arch Linux：`sudo pacman -S libvips`

> [!IMPORTANT]
> 在本地运行时，部分相对链接似乎不能被很好地处理，而它们在 GitHub Pages 上运行正常。因此，在本地出现 404 时，不可轻易地“修复”相对链接，否则可能反而导致此相对链接在 GitHub Pages 上 404。总之，一切以在线站点为准。

## 编辑方法
- 编辑页面：编辑 `src/content/docs/` 里的文件（[参考](https://starlight.astro.build/guides/authoring-content)）。

> HTML 文件可放在 `src/pages`。

- 编辑侧边栏：可编辑 `astro.config.mjs`

- 编辑主题：编辑 `src/styles/custom.css`（[参考](https://starlight.astro.build/guides/css-and-tailwind/)）。

> [!IMPORTANT]
> 在生成链接路径时，markdown 文件名中的大写字母会被统一为小写字母，且 `.` 会被去除，此时若仍使用原文件名作为链接路径则可能导致 404。

## 更多参考
- 前端框架：[Astro documentation](https://docs.astro.build)
- 基于 Astro 的文档生成器：[Starlight’s docs](https://starlight.astro.build/)
- Starlight 自带的代码块编辑器：[Expressive-code](https://expressive-code.com/key-features/text-markers/)
