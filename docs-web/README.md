# Developing

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

For more, Check out [Starlight’s docs](https://starlight.astro.build/) and [the Astro documentation](https://docs.astro.build).

## Sidebar

To edit the side bar edit `astro.config.mjs`

注意：所有链接默认会被转换为小写，即使源 md 文件名是大写。若仍然使用大写，则会 404。

Doc url: <https://clsty.github.io/arCNiso>
