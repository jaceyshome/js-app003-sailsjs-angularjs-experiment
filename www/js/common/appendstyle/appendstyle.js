define(['angular', 'angular_resource'], function(angular) {
  var appModule;
  appModule = angular.module('common.appendstyle', []);
  return appModule.factory("AppendStyle", function($q, Helper) {
    var appendStyle, service, setCurtButtonHoverStyles, setMultipleChoiceOptionAddOnActivatedStyles, setMultipleChoiceOptionAddOnDefaultStyles, setNavigationModuleLabelColors;
    service = {};
    service.data = {};
    appendStyle = function(style) {
      var endMarker, startMarker;
      startMarker = "<style>";
      endMarker = "</style>";
      return angular.element("head").append(startMarker + style + endMarker);
    };
    setCurtButtonHoverStyles = function(data) {
      var classSelector, curtButtonHoverStyles, defaultColor, moduleColor, moduleKey, style, _i, _len, _ref, _ref1;
      curtButtonHoverStyles = {};
      _ref = data.moduleKeys;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        moduleKey = _ref[_i];
        defaultColor = "#000000";
        classSelector = "curtbutton-";
        if (((_ref1 = data.modules[moduleKey]) != null ? _ref1.color : void 0) != null) {
          moduleColor = Helper.colorLuminance(data.modules[moduleKey].color, -0.2);
        } else {
          moduleColor = defaultColor;
        }
        style = "." + classSelector + moduleKey + ":hover, ." + classSelector + moduleKey + ":focus{ color:" + moduleColor + "; background-color: #FFFFFF; text-decoration: none; }";
        appendStyle(style);
        curtButtonHoverStyles[moduleKey] = classSelector + moduleKey;
      }
      return service.data.curtButtonHoverStyles = curtButtonHoverStyles;
    };
    setNavigationModuleLabelColors = function(data) {
      var classSelector, defaultColor, moduleColor, moduleKey, navigationLabelStyles, style, _i, _len, _ref, _ref1;
      navigationLabelStyles = {};
      _ref = data.moduleKeys;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        moduleKey = _ref[_i];
        defaultColor = "#FFFFFF";
        classSelector = "sidenavigation-nav-module-container-";
        if (((_ref1 = data.modules[moduleKey]) != null ? _ref1.color : void 0) != null) {
          moduleColor = data.modules[moduleKey].color;
        } else {
          moduleColor = defaultColor;
        }
        style = "." + classSelector + moduleKey + ":before{ display: block; content: ''; width: 65px; height: 3px; background-color: " + moduleColor + "}";
        appendStyle(style);
        navigationLabelStyles[moduleKey] = classSelector + moduleKey;
      }
      return service.data.navigationLabelStyles = navigationLabelStyles;
    };
    setMultipleChoiceOptionAddOnDefaultStyles = function(data) {
      var classSelector, defaultColor, moduleColor, moduleKey, multipleChoiceAddOnDefaultStyles, style, _i, _len, _ref, _ref1;
      multipleChoiceAddOnDefaultStyles = {};
      _ref = data.moduleKeys;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        moduleKey = _ref[_i];
        defaultColor = "#FFFFFF";
        classSelector = "multiplechoice-add-on-default-";
        if (((_ref1 = data.modules[moduleKey]) != null ? _ref1.color : void 0) != null) {
          moduleColor = data.modules[moduleKey].color;
        } else {
          moduleColor = defaultColor;
        }
        style = "." + classSelector + moduleKey + ":before{border-color:" + moduleColor + " !important}";
        appendStyle(style);
        multipleChoiceAddOnDefaultStyles[moduleKey] = classSelector + moduleKey;
      }
      return service.data.multipleChoiceAddOnDefaultStyles = multipleChoiceAddOnDefaultStyles;
    };
    setMultipleChoiceOptionAddOnActivatedStyles = function(data) {
      var classSelector, defaultColor, moduleColor, moduleKey, multipleChoiceAddOnActivatedStyles, style, _i, _len, _ref, _ref1;
      multipleChoiceAddOnActivatedStyles = {};
      _ref = data.moduleKeys;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        moduleKey = _ref[_i];
        defaultColor = "#FFFFFF";
        classSelector = "multiplechoice-add-on-activated-";
        if (((_ref1 = data.modules[moduleKey]) != null ? _ref1.color : void 0) != null) {
          moduleColor = Helper.colorLuminance(data.modules[moduleKey].color, -0.2);
        } else {
          moduleColor = defaultColor;
        }
        style = "." + classSelector + moduleKey + ":before{border-color:" + moduleColor + " !important}";
        appendStyle(style);
        multipleChoiceAddOnActivatedStyles[moduleKey] = classSelector + moduleKey;
      }
      return service.data.multipleChoiceAddOnActivatedStyles = multipleChoiceAddOnActivatedStyles;
    };
    service.init = function(data) {
      var deferred;
      deferred = $q.defer();
      setNavigationModuleLabelColors(data);
      setMultipleChoiceOptionAddOnDefaultStyles(data);
      setMultipleChoiceOptionAddOnActivatedStyles(data);
      setCurtButtonHoverStyles(data);
      deferred.resolve(service.data);
      return deferred.promise;
    };
    return service;
  });
});

//# sourceMappingURL=appendstyle.js.map
