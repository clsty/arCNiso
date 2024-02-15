import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://starlight.astro.build/reference/configuration
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
      defaultLocale: 'root',
      tableOfContents: { minHeadingLevel: 1, maxHeadingLevel: 2, },
      lastUpdated: true,
      locales: {
        'root': {
          label: '简体中文',
          lang: 'zh-CN',
        },
        // English docs in `src/content/docs/en/`
        en: {
          label: 'English',
          lang: 'en',
        },
      },
			sidebar: [
        {
          label: '通用',
          collapsed: false,
          autogenerate: { directory: 'general' },
        },
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
          label: '安装提示',
          collapsed: false,
          autogenerate: { directory: 'inst-hint' },
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
