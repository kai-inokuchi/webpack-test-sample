# webpack-test-sample

## Install

```
$ npm install
```

* Maven (`mvn`) should be installed to test and send coverage data

## Test

### JavaScript

```
$ npm run test
```

### Java

```
$ mvn test
```

## Build

### JavaScript

```
$ npm run build
# => dist/bundle.js
```

### Java

```
$ mvn clean assembly:assembly
# => target/webpack-test-sample-{version}.jar
```

## Execute Tests and Send Coverage to Coveralls

```
$ npm run coverage
```

(Coveralls token shoud be exported as `COVERALLS_REPO_TOKEN` environment variable.)
