/* jslint node: true */
/* global featureFile, scenarios, steps */
"use strict";

var Yadda = require('yadda');
Yadda.plugins.mocha.ScenarioLevelPlugin.init();

new Yadda.FeatureFileSearch('./test/features').each(function(file) {

    featureFile(file, function(feature, done) {

        var library = require(process.cwd()+'/'+file.replace(/(.*)\/features\/(.*)\.feature$/, '$1/steps/$2.js'));
        var yadda = Yadda.createInstance(library);

        scenarios(feature.scenarios, function(scenario) {
            yadda.run(scenario.steps, done);
        });
    });
});
