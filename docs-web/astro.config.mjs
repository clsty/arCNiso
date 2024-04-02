import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://starlight.astro.build/reference/configuration
export default defineConfig({
  site: 'https://arcn.celestialy.top',
  base: '/',
//  build: {
//      format: 'directory',
//  },
	integrations: [
		starlight({
      title: 'arCNiso 指南',
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
          label: '关于',
          collapsed: false,
          autogenerate: { directory: 'about' },
        },
        {
          label: '获取与使用',
          collapsed: false,
          autogenerate: { directory: 'using' },
        },
        {
          label: '设计与理念',
          collapsed: false,
          autogenerate: { directory: 'design' },
        },
        {
          label: '构建与开发',
          collapsed: true,
          badge: { text: 'Dev' },
          autogenerate: { directory: 'dev' },
        },
			],
		}),
	],
});
