# Openwhisk Playground [![Build Status](https://secure.travis-ci.org/zirpins/openwhisk-playground.png?branch=master)](http://travis-ci.org/zirpins/openwhisk-playground)

Sample project for setting up test-driven development of 
OpenWhisk actions using javascript.

## Service Model

The project exposes a REST style API via OpenWhisk. The API is 
implemented based on this 
[project](https://github.com/IBM/openwhisk-serverless-apis).


## Unit Testing

Javascript actions are built via [grunt](https://gruntjs.com). This 
includes local unit testing of action logic via 
[nodeunit](https://github.com/gruntjs/grunt-contrib-nodeunit). This 
[article](http://markdalgleish.com/2012/09/test-driven-node-js-development-with-grunt/)
describes how to install and setup such projects.

## Continuous integration testing

Integration testing is don continuously via 
[travis ci](https://travis-ci.org).