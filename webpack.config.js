const path = require('path');
const HtmlPlugin = require('html-webpack-plugin');
const HtmlIncludeAssetsPlugin = require('html-webpack-include-assets-plugin');

module.exports = {
    entry: './src/index',
    output: {
        path: path.join(__dirname, 'dist'),
        filename: 'bundle.js'
    },
    resolve: {
        extensions: ['.js', '.elm', '.less']
    },
    plugins: [
        new HtmlPlugin({ title: 'Cache' }),
        new HtmlIncludeAssetsPlugin({
            assets: [
                'https://fonts.googleapis.com/css?family=Roboto',
                'https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'
            ].map(path => ({ path, type: 'css' })),
            append: true
        })
    ],
    module: {
        rules: [
            {
                test: /\.elm$/,
                use: ['elm-webpack-loader']
            },
            {
                test: /\.less$/,
                use: ['style-loader', 'css-loader', 'less-loader']
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: ['babel-loader']
            }
        ]
    }
};
