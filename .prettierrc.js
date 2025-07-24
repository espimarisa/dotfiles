/**
 * @file Configuration file for Prettier.
 * @see https://prettier.io/docs/configuration
 * @type {import("prettier").Config}
 * @license zlib
 */

// @ts-check

export default {
	arrowParens: "always",
	bracketSameLine: true,
	bracketSpacing: true,
	embeddedLanguageFormatting: "auto",
	endOfLine: "lf",
	experimentalTernaries: true,
	htmlWhitespaceSensitivity: "css",
	jsxSingleQuote: false,
	objectWrap: "preserve",
	overrides: [
		{
			/**
			 * Prettier puts trailing commas on jsonc files by default.
			 * This is *technically* allowed, but many parsers do not allow it.
			 * @see https://github.com/prettier/prettier/issues/15956
			 */

			files: ["**/*.jsonc"],
			options: {
				trailingComma: "none",
			},
		},
	],
	printWidth: 80,
	proseWrap: "preserve",
	quoteProps: "consistent",
	semi: true,
	singleAttributePerLine: false,
	singleQuote: false,
	tabWidth: 2,
	trailingComma: "all",
	useTabs: true,
	vueIndentScriptAndStyle: true,
};
