<https://clsty.github.io/arCNiso>

# 开发

| 命令                   | 作用                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

更多可参见 [Starlight’s docs](https://starlight.astro.build/) 和 [the Astro documentation](https://docs.astro.build)。

- 编辑侧边栏：可编辑 `astro.config.mjs`

- 注意：所有链接默认会被转换为小写，即使源 md 文件名是大写。若仍然使用大写，则会 404。

- 注意：国内用户 `npm install` 时可能报错`致命错误：vips/vips8：没有那个文件或目录`，为此可以手动安装 `libvips`，比如：
```bash
sudo pacman -S libvips
```
