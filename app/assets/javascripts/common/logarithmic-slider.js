var LOG_SLIDER = (function () {
  var gMinPrice = 100,
      gMaxPrice = 1000000,
      module = {};

  module.gMinPrice = gMinPrice;
  module.gMaxPrice = gMaxPrice;

  module.expon = function (val){
      var minv = Math.log(gMinPrice);
      var maxv = Math.log(gMaxPrice);
      var scale = (maxv-minv) / (gMaxPrice-gMinPrice);
      return Math.exp(minv + scale*(val-gMinPrice));

  }

  module.logposition = function (val){
      var minv = Math.log(gMinPrice);
      var maxv = Math.log(gMaxPrice);
      var scale = (maxv-minv) / (gMaxPrice-gMinPrice);
      return (Math.log(val)-minv) / scale + gMinPrice;
  }

  return module;
}());
