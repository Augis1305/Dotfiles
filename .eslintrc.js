exports = {
    oot: true,
    extends: "next",
    rules: {
        'no-unused-vars': [
            'error',
            {
                argsIgnorePattern: '^_',
                varsIgnorePattern: '^_'
            }
        ],
        "@typescript-eslint/no-explicit-any": "off"
    }
}
