const path = require('path')

const rootDir = __dirname

const OFF = 0
const WARNING = 1
const ERROR = 2

module.exports = {
  env: {
    browser: true,
    jest: true,
  },
  extends: [
    'airbnb',
    'airbnb-typescript',
    'airbnb/hooks',
    'plugin:@typescript-eslint/eslint-recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:import/errors',
    'plugin:import/warnings',
    'plugin:import/typescript',
    'prettier',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    tsconfigRootDir: rootDir,
    project: 'tsconfig.json',
  },

  plugins: ['import', '@typescript-eslint', 'sort-export-all'],
  rules: {
    '@typescript-eslint/explicit-function-return-type': OFF,
    '@typescript-eslint/explicit-module-boundary-types': OFF,
    '@typescript-eslint/prefer-interface': OFF,
    '@typescript-eslint/no-unused-vars': [
      ERROR,
      {
        argsIgnorePattern: '^_',
      },
    ],
    '@typescript-eslint/comma-dangle': [
      ERROR,
      {
        arrays: 'always-multiline',
        objects: 'always-multiline',
        imports: 'always-multiline',
        exports: 'always-multiline',
        functions: 'never',
      },
    ],
    'no-return-assign': OFF,
    'no-console': ERROR,
    'import/no-extraneous-dependencies': [
      'error',
      {
        devDependencies: [
          '**/*.setup.{js,ts}',
          '**/*.config.{js,ts}',
          '**/*.spec.{ts,tsx}',
          '**/.storybook/**/*.{ts,tsx}',
          '**/*.stories.{ts,tsx}',
          '**/__fixtures__/**/*.{ts,tsx}',
          '**/mocks/**/*.{ts,tsx}',
        ],
        peerDependencies: false,
      },
    ],
    'import/order': [
      ERROR,
      {
        groups: [
          'builtin',
          'external',
          'internal',
          'index',
          'sibling',
          'parent',
        ],
        pathGroups: [
          {
            group: 'external',
            position: 'before',
          },
        ],
        alphabetize: {
          order: 'asc',
          caseInsensitive: true,
        },
        'newlines-between': 'always',
      },
    ],
    'sort-imports': ['error', { ignoreDeclarationSort: true }],
    'sort-export-all/sort-export-all': 'warn',
    'import/no-named-export': OFF,
    'import/no-relative-packages': OFF,
    'import/newline-after-import': ERROR,
    'import/named': OFF, // ref: https://github.com/benmosher/eslint-plugin-import/issues/1282
    'import/prefer-default-export': OFF,
    'jsx-a11y/anchor-is-valid': OFF,
    semi: ['error', 'never', { beforeStatementContinuationChars: 'never' }],
    'semi-spacing': ['error', { after: true, before: false }],
    'semi-style': ['error', 'first'],
    'no-extra-semi': 'error',
    'no-unexpected-multiline': ERROR,
    'no-unreachable': ERROR,
    '@typescript-eslint/semi': OFF,
  },
}