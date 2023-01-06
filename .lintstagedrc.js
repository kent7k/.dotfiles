module.exports = {
  '**/*.ts?(x)': (files) => {
    return [
      'tsc -p tsconfig.json --noEmit',
      `eslint --fix ${files.join(' ')}`,
      `prettier --write ${files.join(' ')}`,
    ]
  },
  '**/*.{css,scss}': (files) => {
    return [
      `stylelint --fix ${files.join(' ')}`,
    ]
  },
  '*.md': (files) => {
    return [
      `prettier --parser markdown ${files.join()} --write`,
      `markdownlint ${files.join(' ')} -i .github/pull_request_template.md`,
    ]
  },
}
