module.exports = {
  // Run ESLint and Prettier on staged TypeScript/JavaScript files
  'app/src/**/*.{ts,tsx,js,jsx}': [
    'cd app && npm run lint:fix',
    'cd app && npm run format',
    'git add'
  ],
  
  // Run Prettier on staged JSON, YAML, and Markdown files
  '**/*.{json,yaml,yml,md}': [
    'prettier --write',
    'git add'
  ],
  
  // Run Prettier on staged configuration files
  '**/*.{js,ts}': [
    'prettier --write',
    'git add'
  ]
};
