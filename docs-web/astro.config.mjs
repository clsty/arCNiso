import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
  site: 'https://clsty.github.io',
  base: '/arCNiso',
//  build: {
//      format: 'directory',
//  },
	integrations: [
		starlight({
      title: 'arCNiso 文档',
			social: {
        github: 'https://github.com/clsty/arCNiso',
			},
      editLink: {
          baseUrl: 'https://github.com/clsty/arCNiso/tree/main/docs-web',
      },
      customCss: ['./src/styles/custom.css'],
      favicon: '/favicon.ico',
			sidebar: [
        { label: '总述', link: 'readme', },
        {
          label: '构建与维护',
          collapsed: false,
          items: [
            { label: '构建', link: 'dev/build' },
            { label: '于 Docker 中构建', link: 'dev/buildindocker' },
            { label: '定制', link: 'dev/modify' },
            { label: '维护', link: 'dev/maintaining' },
          ]
        },
        {
          label: '其他',
          collapsed: true,
          autogenerate: { directory: 'misc' },
        },
			],
		}),
	],
});
