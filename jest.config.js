module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/app/src'],
  testMatch: [
    '**/__tests__/**/*.ts',
    '**/?(*.)+(spec|test).ts'
  ],
  transform: {
    '^.+\\.ts$': 'ts-jest'
  },
  collectCoverageFrom: [
    'app/src/**/*.ts',
    '!app/src/**/*.d.ts',
    '!app/src/main.ts',
    '!app/src/test/**',
    '!app/src/index.ts'
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  moduleNameMapper: {
    '^@domain/(.*)$': '<rootDir>/app/src/domain/$1',
    '^@application/(.*)$': '<rootDir>/app/src/application/$1',
    '^@interfaces/(.*)$': '<rootDir>/app/src/interfaces/$1',
    '^@infrastructure/(.*)$': '<rootDir>/app/src/infrastructure/$1',
    '^@shared/(.*)$': '<rootDir>/app/src/shared/$1'
  },
  setupFilesAfterEnv: ['<rootDir>/app/src/test/setup.ts'],
  testTimeout: 10000,
  verbose: true,
  clearMocks: true,
  restoreMocks: true
};
