blink = function(text, interval = 1) {
  htmlwidgets::createWidget(
    'blink',
    x = list(text = text, interval = interval),
    dependencies = htmltools::htmlDependency(
      'blink', '0.1', src = c(href = ''), head = '<script>
HTMLWidgets.widget({
  name: "blink", type: "output",
  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        setInterval(function() {
          el.innerText = el.innerText == "" ? x.text : "";
        }, x.interval * 1000);
      },
      resize: function(width, height) {}
    };
  }
});
</script>'))}